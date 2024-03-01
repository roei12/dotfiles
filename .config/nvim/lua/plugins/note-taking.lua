return {
    "nvim-neorg/neorg",
    cmd = "Neorg",
    lazy = "True",
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.summary"] = {},
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        work = "~/Documents/notes",
                    },
                    default_workspace = "work",
                },
            },
        },
    },
}
