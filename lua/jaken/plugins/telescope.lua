return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- Keymaps
    local keymap = vim.keymap -- for conciseness

    -- Existing keymaps
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fj", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy find in current file" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

    -- Global search with Cmd+Shift+F (VSCode style)
    keymap.set("n", "<D-S-f>", "<cmd>Telescope live_grep<cr>", { desc = "Global search in project" })

    -- Go to definition
    vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "Go to definition (Telescope)" })

    -- Double leader = open file finder (like VSCode's Shift-Shift)
    keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Quick open file" })
  end,
}
