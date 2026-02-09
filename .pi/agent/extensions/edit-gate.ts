/**
 * Edit Gate Extension
 *
 * Prompts for confirmation before allowing file edits or writes.
 * Pi already shows the diff preview, so this extension just provides
 * the confirmation dialog and "Yes to all" (yolo mode) functionality.
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  // Yolo mode: allow all edits without confirmation until next user prompt
  let yoloEnabled = false;

  // Reset yolo mode on each new user prompt
  pi.on("agent_start", async () => {
    yoloEnabled = false;
  });

  pi.on("tool_call", async (event, ctx) => {
    // Only handle edit and write tools
    if (event.toolName !== "edit" && event.toolName !== "write") {
      return undefined;
    }

    // Skip if yolo mode is enabled
    if (yoloEnabled) {
      return undefined;
    }

    if (!ctx.hasUI) {
      // In non-interactive mode, let it through
      return undefined;
    }

    const input = event.input as {
      path: string;
      oldText?: string;
      newText?: string;
      content?: string;
    };
    const filePath = input.path;
    const action = event.toolName === "edit" ? "Edit" : "Write";

    const prompt = `⚠️ ${action} file: ${filePath}\n\nAllow?`;

    const choice = await ctx.ui.select(prompt, ["Yes", "Yes to all", "No"]);

    if (choice === "Yes to all") {
      yoloEnabled = true;
      return undefined;
    }

    if (choice !== "Yes") {
      // Ask for a reason
      const reason = await ctx.ui.input(
        "Reason for blocking (leave empty for default):",
      );
      const blockReason = reason?.trim() || "Blocked by user";
      return { block: true, reason: blockReason };
    }

    return undefined;
  });
}
