/**
 * Questionnaire Tool - Tool for asking open-ended text questions with hints
 *
 * Single question: editor input
 * Multiple questions: tab bar navigation between questions
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { Editor, type EditorTheme, Key, matchesKey, Text, truncateToWidth } from "@mariozechner/pi-tui";
import { Type } from "@sinclair/typebox";

// Types
interface Question {
    id: string;
    label: string;
    question: string;
    hints?: string;
}

interface Answer {
    id: string;
    answer: string;
}

interface QuestionnaireResult {
    questions: Question[];
    answers: Answer[];
    cancelled: boolean;
}

// Schema
const QuestionSchema = Type.Object({
    id: Type.String({ description: "Unique identifier for this question" }),
    label: Type.Optional(
        Type.String({
            description: "Short contextual label for tab bar, e.g. 'Scope', 'Priority' (defaults to Q1, Q2)",
        }),
    ),
    question: Type.String({ description: "The question text to display" }),
    hints: Type.Optional(Type.String({ description: "Optional hints including explanations, tradeoffs, and recommendations" })),
});

const QuestionnaireParams = Type.Object({
    questions: Type.Array(QuestionSchema, { description: "Questions to ask the user" }),
});

function errorResult(
    message: string,
    questions: Question[] = [],
): { content: { type: "text"; text: string }[]; details: QuestionnaireResult } {
    return {
        content: [{ type: "text", text: message }],
        details: { questions, answers: [], cancelled: true },
    };
}

export default function questionnaire(pi: ExtensionAPI) {
    pi.registerTool({
        name: "questionnaire",
        label: "Questionnaire",
        description:
            "Ask the user open-ended questions. Use for clarifying requirements, getting preferences, or confirming decisions.",
        parameters: QuestionnaireParams,

        async execute(_toolCallId, params, _signal, _onUpdate, ctx) {
            if (!ctx.hasUI) {
                return errorResult("Error: UI not available (running in non-interactive mode)");
            }
            if (params.questions.length === 0) {
                return errorResult("Error: No questions provided");
            }

            // Normalize questions with defaults
            const questions: Question[] = params.questions.map((q, i) => ({
                ...q,
                label: q.label || `Q${i + 1}`,
            }));

            const isMulti = questions.length > 1;
            const totalTabs = questions.length + 1; // questions + Submit

            const result = await ctx.ui.custom<QuestionnaireResult>((tui, theme, _kb, done) => {
                // State
                let currentTab = 0;
                let cachedLines: string[] | undefined;
                const answers = new Map<string, Answer>();

                // Editor for user input
                const editorTheme: EditorTheme = {
                    borderColor: (s) => theme.fg("accent", s),
                    selectList: {
                        selectedPrefix: (t) => theme.fg("accent", t),
                        selectedText: (t) => theme.fg("accent", t),
                        description: (t) => theme.fg("muted", t),
                        scrollInfo: (t) => theme.fg("dim", t),
                        noMatch: (t) => theme.fg("warning", t),
                    },
                };
                const editor = new Editor(tui, editorTheme);

                // Helpers
                function refresh() {
                    cachedLines = undefined;
                    tui.requestRender();
                }

                function submit(cancelled: boolean) {
                    done({ questions, answers: Array.from(answers.values()), cancelled });
                }

                function currentQuestion(): Question | undefined {
                    return questions[currentTab];
                }

                function allAnswered(): boolean {
                    return questions.every((q) => {
                        const answer = answers.get(q.id);
                        return answer && answer.answer.trim().length > 0;
                    });
                }

                function saveCurrentAnswer() {
                    const q = currentQuestion();
                    if (!q) return;
                    const answer = editor.getText().trim();
                    answers.set(q.id, { id: q.id, answer });
                    if (!isMulti) {
                        submit(false);
                    } else {
                        // Advance to next question or to submit tab
                        currentTab = Math.min(currentTab + 1, questions.length);
                        // Load next question's answer if exists
                        const nextQ = questions[currentTab];
                        if (nextQ) {
                            editor.setText(answers.get(nextQ.id)?.answer || "");
                        } else {
                            editor.setText("");
                        }
                        refresh();
                    }
                }

                function handleInput(data: string) {
                    // Submit tab
                    if (currentTab === questions.length) {
                        if (matchesKey(data, Key.enter) && allAnswered()) {
                            submit(false);
                        } else if (matchesKey(data, Key.escape)) {
                            submit(true);
                        } else if (matchesKey(data, Key.shift("tab")) || matchesKey(data, Key.left)) {
                            // Navigate back to last question
                            currentTab = questions.length - 1;
                            const prevQ = questions[currentTab];
                            editor.setText(answers.get(prevQ.id)?.answer || "");
                            refresh();
                            return;
                        } else if (matchesKey(data, Key.tab) || matchesKey(data, Key.right)) {
                            // Navigate forward to first question (wrap around)
                            currentTab = 0;
                            const firstQ = questions[currentTab];
                            editor.setText(answers.get(firstQ.id)?.answer || "");
                            refresh();
                            return;
                        }
                        return;
                    }

                    // Tab navigation (multi-question only)
                    if (isMulti) {
                        if (matchesKey(data, Key.tab) || matchesKey(data, Key.right)) {
                            // Save current answer before switching
                            saveCurrentAnswer();
                            return;
                        }
                        if (matchesKey(data, Key.shift("tab")) || matchesKey(data, Key.left)) {
                            // Save current answer first
                            const q = currentQuestion();
                            if (q) {
                                const answer = editor.getText().trim();
                                answers.set(q.id, { id: q.id, answer });
                            }
                            // Navigate back
                            currentTab = (currentTab - 1 + totalTabs) % totalTabs;
                            if (currentTab < questions.length) {
                                const nextQ = questions[currentTab];
                                editor.setText(answers.get(nextQ.id)?.answer || "");
                            } else {
                                editor.setText("");
                            }
                            refresh();
                            return;
                        }
                    }

                    // For question tabs: Ctrl+Enter to submit answer, Esc to cancel all
                    const q = currentQuestion();
                    if (matchesKey(data, Key.ctrl("m")) && q) {
                        saveCurrentAnswer();
                        return;
                    }
                    if (matchesKey(data, Key.escape)) {
                        submit(true);
                        return;
                    }

                    // Otherwise, route to editor (handles normal Enter for newlines)
                    editor.handleInput(data);
                    refresh();
                }

                function render(width: number): string[] {
                    if (cachedLines) return cachedLines;

                    const lines: string[] = [];
                    const q = currentQuestion();

                    // Helper to add truncated line
                    const add = (s: string) => lines.push(truncateToWidth(s, width));

                    add(theme.fg("accent", "─".repeat(width)));

                    // Tab bar (multi-question only)
                    if (isMulti) {
                        const tabs: string[] = ["← "];
                        for (let i = 0; i < questions.length; i++) {
                            const isActive = i === currentTab;
                            const answer = answers.get(questions[i].id);
                            const isAnswered = answer && answer.answer.trim().length > 0;
                            const lbl = questions[i].label;
                            const box = isAnswered ? "■" : "□";
                            const color = isAnswered ? "success" : "muted";
                            const text = ` ${box} ${lbl} `;
                            const styled = isActive ? theme.bg("selectedBg", theme.fg("text", text)) : theme.fg(color, text);
                            tabs.push(`${styled} `);
                        }
                        const canSubmit = allAnswered();
                        const isSubmitTab = currentTab === questions.length;
                        const submitText = " ✓ Submit ";
                        const submitStyled = isSubmitTab
                            ? theme.bg("selectedBg", theme.fg("text", submitText))
                            : theme.fg(canSubmit ? "success" : "dim", submitText);
                        tabs.push(`${submitStyled} →`);
                        add(` ${tabs.join("")}`);
                        lines.push("");
                    }

                    // Content
                    if (currentTab === questions.length) {
                        // Submit tab - show all answers
                        add(theme.fg("accent", theme.bold(" Ready to submit")));
                        lines.push("");
                        for (const question of questions) {
                            const answer = answers.get(question.id);
                            if (answer) {
                                const displayAnswer = answer.answer || "(no response)";
                                add(`${theme.fg("muted", ` ${question.label}: `)}${theme.fg("text", displayAnswer)}`);
                            }
                        }
                        lines.push("");
                        if (allAnswered()) {
                            add(theme.fg("success", " Press Enter to submit"));
                        } else {
                            const missing = questions
                                .filter((q) => !answers.has(q.id))
                                .map((q) => q.label)
                                .join(", ");
                            add(theme.fg("warning", ` Unanswered: ${missing}`));
                        }
                    } else if (q) {
                        // Question tab - show question, hints, and editor
                        add(theme.fg("text", ` ${q.question}`));
                        if (q.hints) {
                            lines.push("");
                            for (const hintLine of q.hints.split('\n')) {
                                add(`  ${theme.fg("dim", hintLine)}`);
                            }
                        }
                        lines.push("");
                        add(theme.fg("muted", " Your answer:"));
                        for (const line of editor.render(width - 2)) {
                            add(` ${line}`);
                        }
                        lines.push("");
                        // const helpText = isMulti
                        //     ? " Enter to submit this answer • Tab/Shift+Tab to navigate • Esc to cancel all"
                        //     : " Enter to submit • Esc to cancel";
                        // add(theme.fg("dim", helpText));
                    }

                    lines.push("");
                    add(theme.fg("accent", "─".repeat(width)));

                    cachedLines = lines;
                    return lines;
                }

                return {
                    render,
                    invalidate: () => {
                        cachedLines = undefined;
                    },
                    handleInput,
                };
            });

            if (result.cancelled) {
                return {
                    content: [{ type: "text", text: "User cancelled the questionnaire" }],
                    details: result,
                };
            }

            const answerLines = result.answers.map((a) => {
                const qLabel = questions.find((q) => q.id === a.id)?.label || a.id;
                const displayAnswer = a.answer || "(no response)";
                return `${qLabel}: ${displayAnswer}`;
            });

            return {
                content: [{ type: "text", text: answerLines.join("\n") }],
                details: result,
            };
        },

        renderCall(args, theme) {
            const qs = (args.questions as Question[]) || [];
            const count = qs.length;
            const labels = qs.map((q) => q.label || q.id).join(", ");
            let text = theme.fg("toolTitle", theme.bold("questionnaire "));
            text += theme.fg("muted", `${count} question${count !== 1 ? "s" : ""}`);
            if (labels) {
                text += theme.fg("dim", ` (${truncateToWidth(labels, 40)})`);
            }
            return new Text(text, 0, 0);
        },

        renderResult(result, _options, theme) {
            const details = result.details as QuestionnaireResult | undefined;
            if (!details) {
                const text = result.content[0];
                return new Text(text?.type === "text" ? text.text : "", 0, 0);
            }
            if (details.cancelled) {
                return new Text(theme.fg("warning", "Cancelled"), 0, 0);
            }
            const lines = details.answers.map((a) => {
                const qLabel = details.questions.find((q) => q.id === a.id)?.label || a.id;
                const displayAnswer = a.answer || "(no response)";
                return `${theme.fg("success", "✓ ")}${theme.fg("accent", qLabel)}: ${theme.fg("text", displayAnswer)}`;
            });
            return new Text(lines.join("\n"), 0, 0);
        },
    });
}
