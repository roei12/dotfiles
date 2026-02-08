return {
    'minuet-ai.nvim',
    lazy = false,
    -- event = "InsertEnter",
    after = function()
        require('minuet').setup {
            provider = 'openai_fim_compatible',
            n_completions = 1, -- recommend for local model for resource saving
            -- I recommend beginning with a small context window size and incrementally
            -- expanding it, depending on your local computing power. A context window
            -- of 512, serves as an good starting point to estimate your computing
            -- power. Once you have a reliable estimate of your local computing power,
            -- you should adjust the context window to a larger value.
            context_window = 512,
            provider_options = {
                openai_fim_compatible = {
                    api_key = function()
                        -- Local Key
                        return "sk-lm-fR0pYFv3:fovSVQ2AMuDliuGjczgp"
                    end,
                    name = 'lmstudio',
                    end_point = 'http://localhost:1234/v1/completions',
                    model = 'sweep-next-edit-1.5b-mlx',
                    optional = {
                        max_tokens = 56,
                        top_p = 0.9,
                    },
                    system = "{{{prompt}}}\n{{{guidelines}}}\n{{{n_completion_template}}}\n\nALWAYS complete A SINGLE LINE"

                    -- system = mc.default_system_prefix_first,
                    -- chat_input = mc.default_chat_input_prefix_first,
                    -- few_shots = mc.default_few_shots_prefix_first,
                    -- template = {
                    --     prompt = function(context_before_cursor, context_after_cursor, _)
                    --         return '<|fim_prefix|>'
                    --             .. context_before_cursor
                    --             .. '<|fim_suffix|>'
                    --             .. context_after_cursor
                    --             .. '<|fim_middle|>'
                    --     end,
                    -- },
                },
            },
            virtualtext = {
                auto_trigger_ft = { '*' },
                keymap = {
                    -- accept whole completion
                    accept = '<A-A>',
                    -- accept one line
                    accept_line = '<A-a>',
                    -- accept n lines (prompts for number)
                    -- e.g. "A-z 2 CR" will accept 2 lines
                    accept_n_lines = '<A-z>',
                    -- Cycle to prev completion item, or manually invoke completion
                    prev = '<A-[>',
                    -- Cycle to next completion item, or manually invoke completion
                    next = '<A-]>',
                    dismiss = '<A-e>',
                },
            },
        }
    end,

}
