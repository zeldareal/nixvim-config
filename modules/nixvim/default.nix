{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      ignorecase = true;
      smartcase = true;
      clipboard = "unnamedplus";
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 200;
      cursorline = true;
      scrolloff = 8;
      sidescrolloff = 8;
      termguicolors = true;
    };

    colorschemes.tokyonight = {
      enable = true;
      settings.style = "storm";
    };

    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body) 
            end
          '';
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
        };
      };

      luasnip.enable = true;
      friendly-snippets.enable = true;

      mini = {
        enable = true;
        modules = {
          pairs = { };
          comment = { };
          ai = { };
        };
      };

      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          window = {
            width = 30;
            position = "left";
          };
        };
      };

      oil = {
        enable = true;
        settings = {
          view_options.show_hidden = true;
        };
      };

      harpoon = {
        enable = true;
        enableTelescope = true;
      };

      illuminate = {
        enable = true;
        settings = {
          underCursor = true;
          filetypesDenylist = [
            "neo-tree"
            "alpha"
            "toggleterm"
          ];
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
          float_opts = {
            border = "curved";
            width = 120;
            height = 30;
          };
          open_mapping = "[[<C-\\>]]";
        };
      };

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
        };
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>/" = {
            action = "current_buffer_fuzzy_find";
            options.desc = "Search in current buffer";
          };
        };
        settings = {
          defaults = {
            vimgrep_arguments = [
              "rg"
              "--color=never"
              "--no-heading"
              "--with-filename"
              "--line-number"
              "--column"
              "--smart-case"
            ];
          };
        };
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
        };
      };

      which-key = {
        enable = true;
        settings = {
          delay = 100;
          spec = [
            {
              __unkeyed-1 = "<leader>1";
              hidden = true;
            }
            {
              __unkeyed-1 = "<leader>2";
              hidden = true;
            }
            {
              __unkeyed-1 = "<leader>3";
              hidden = true;
            }
            {
              __unkeyed-1 = "<leader>4";
              hidden = true;
            }
          ];
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lspFallback = true;
            timeoutMs = 500;
          };
          formatters_by_ft = {
            lua = [ "stylua" ];
            nix = [ "nixfmt" ];
          };
        };
      };

      lint = {
        enable = true;
        lintersByFt = { };
      };

      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          nixd.enable = true;
        };
      };

      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      lualine = {
        enable = true;
        settings.options.theme = "auto";
      };

      bufferline = {
        enable = true;
        settings.options.diagnostics = "nvim_lsp";
      };

      indent-blankline = {
        enable = true;
        settings.scope.enabled = true;
      };

      alpha = {
        enable = true;
        theme = "dashboard";
      };

      web-devicons.enable = true;
      noice.enable = true;
      notify.enable = true;

      persistence.enable = true;
    };

    extraConfigLua = ''
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')

      dashboard.section.header.val = {
        "                                                     ",
        "  ███████╗███████╗██╗     ██████╗  █████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ╚══███╔╝██╔════╝██║     ██╔══██╗██╔══██╗██║   ██║██║████╗ ████║ ",
        "    ███╔╝ █████╗  ██║     ██║  ██║███████║██║   ██║██║██╔████╔██║ ",
        "   ███╔╝  ██╔══╝  ██║     ██║  ██║██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ███████╗███████╗███████╗██████╔╝██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚══════╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
        "                 // yet another nvim config //          ",
      }

      alpha.setup(dashboard.opts)

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
        float_opts = { border = "curved" },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.keymap.set("n", "<leader>lg", _lazygit_toggle, { desc = "Lazygit" })

      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- any plugin-dependent code here
        end
      })
    '';

    extraPackages = with pkgs; [
      stylua
      nixfmt-rfc-style
      lua-language-server
      nixd
      ripgrep
      fd
      lazygit
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle file explorer";
      }
      {
        mode = "n";
        key = "<leader>o";
        action = "<cmd>Oil<cr>";
        options.desc = "Open parent directory";
      }
      {
        mode = "n";
        key = "<leader>a";
        action = "<cmd>lua require('harpoon'):list():append()<cr>";
        options.desc = "Harpoon add file";
      }
      {
        mode = "n";
        key = "<leader>h";
        action = "<cmd>lua local harpoon = require('harpoon'); harpoon.ui:toggle_quick_menu(harpoon:list())<cr>";
        options.desc = "Harpoon quick menu";
      }
      {
        mode = "n";
        key = "<leader>1";
        action = "<cmd>lua require('harpoon'):list():select(1)<cr>";
        options.desc = "Harpoon file 1";
      }
      {
        mode = "n";
        key = "<leader>2";
        action = "<cmd>lua require('harpoon'):list():select(2)<cr>";
        options.desc = "Harpoon file 2";
      }
      {
        mode = "n";
        key = "<leader>3";
        action = "<cmd>lua require('harpoon'):list():select(3)<cr>";
        options.desc = "Harpoon file 3";
      }
      {
        mode = "n";
        key = "<leader>4";
        action = "<cmd>lua require('harpoon'):list():select(4)<cr>";
        options.desc = "Harpoon file 4";
      }
    ];
  };
}
