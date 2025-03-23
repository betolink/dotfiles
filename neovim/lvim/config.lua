-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

require("telescope").setup{
  defaults = {
    preview = {
        filesize_limit = 0.4, -- MB
        mime_hook = function(filepath, bufnr, opts)
        local is_image = function(filepath)
          local image_extensions = {'png','jpg'}   -- Supported image formats
          local split_path = vim.split(filepath:lower(), '.', {plain=true})
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _ )
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d..'\r\n')
            end
          end
          vim.fn.jobstart(
            {
              'chafa', filepath  -- Terminal image viewer command
            }, 
            {on_stdout=send_output, stdout_buffered=true, pty=true})
        else
          require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
        end
      end
    }
  }
}

lvim.builtin.telescope.defaults.file_ignore_patterns = {
    "vendor/*",
    "%.lock",
    "__pycache__/*",
    "%.sqlite3",
    "%.ipynb",
    "node_modules/*",
    ".git/",
    "%.webp",
    ".github/",
    ".idea/",
    ".settings/",
    ".vscode/",
    "__pycache__/",
    "build/",
    "env/",
    "gradle/",
    "node_modules/",
    "target/",
    "%.pdb",
    "%.cache",
  }

lvim.plugins = {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "ChristianChiarulli/swenv.nvim"
  },
  {
    "stevearc/dressing.nvim"
  },
  {
    "EdenEast/nightfox.nvim",
    build = ":NightfoxCompile",
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "mattn/vim-gist",
    event = "BufRead",
    dependencies = "mattn/webapi-vim",
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
     require('symbols-outline').setup()
    end
  },
  { "nvim-lua/plenary.nvim" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" }
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "deepseek",
          keymaps = {
            send = {
              modes = { n = "<C-S>", i = "<C-s>" },
            },
            close = {
              modes = { n = "<C-c>", i = "<C-c>" },
            },
          },
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "deepseek",
        }
      },
      display = {
        chat = {
          intro_message = "Welcome to CodeCompanion betolink ✨! Press ? for options",
          show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
          separator = "---", -- The separator between the different messages in the chat buffer
          show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
          show_settings = false, -- Show LLM settings at the top of the chat buffer?
          show_token_count = true, -- Show the token count for each response?
          start_in_insert_mode = false, -- Open the chat buffer in insert mode?
        },
      },
        -- Set debug logging
      log_level = "DEBUG",
      init = function()
        require("plugins.codecompanion.fidget-spinner"):init()
      end,
      config = function(_, opts)
        -- First ensure the YAML parser is installed
        require("nvim-treesitter.install").ensure_installed("yaml")
        -- Then setup the plugin with the options
        require("codecompanion").setup(opts)
      end,
    },
  },
  
}

lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.normal_mode["<C-PageUp>"] = "ddkP"
lvim.keys.normal_mode["<C-PageDown>"] = "ddjP"
lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

lvim.colorscheme = "duskfox"
vim.opt.tabstop = 2
vim.opt.expandtab = true

local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end

copilot.setup {
  suggestion = {
    keymap = {
      accept = "<c-l>",
      next = "<c-j>",
      prev = "<c-k>",
      dismiss = "<c-h>",
    },
  },
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<c-s>", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)


lvim.lsp.automatic_configuration.skipped_servers = { "pylsp" }

-- Set up Pyright for Python LSP features
require("lvim.lsp.manager").setup("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Set up Ruff LSP for linting, diagnostics, and autoformatting with import sorting
require("lvim.lsp.manager").setup("ruff", {
  init_options = {
    settings = {
      args = {
        "--select=I,E,F,W",  -- Enable import sorting and other rules
      },
    },
  },
})

-- Set up Mypy for type checking
require("lvim.lsp.manager").setup("mypy", {
  settings = {
    python = {
      typeCheckingMode = "basic",  -- You can use "strict" for more rigorous type checking
    },
  },
})

-- Configure null-ls for formatters and linters (use ruff for both)
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- Use Mypy for additional type checking
    null_ls.builtins.diagnostics.mypy.with({
      extra_args = { "--ignore-missing-imports" },  -- Optional: Ignore missing imports for more lenient checks
    }),
    null_ls.builtins.formatting.ruff.with({
      args = { "--select=I,E,F,W", "--fix" }
    }),
  },
})

-- Enable treesitter-based folding for Python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99  -- Start with all folds open
  end
})

-- vim.opt.fillchars = { fold = " " }
-- vim.opt.foldmethod = "indent"
-- vim.opt.foldenable = true
-- vim.opt.foldlevel = 99
-- lvim.builtin.which_key.setup.plugins.presets.z = true


-- Enable format on save for Python files
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

lvim.builtin.which_key.setup.plugins.presets.z = true

