return {
    "folke/which-key.nvim",
    -- event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local status_ok, which_key = pcall(require, "which-key")
        if not status_ok then
            return
        end

        local setup = {
            plugins = {
                marks = true, -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                spelling = {
                    enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                presets = {
                    operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                    motions = true, -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true, -- default bindings on <c-w>
                    nav = true, -- misc bindings to work with windows
                    z = true, -- bindings for folds, spelling and others prefixed with z
                    g = true, -- bindings for prefixed with g
                },
            },
            -- add operators that will trigger motion and text object completion
            -- to enable all native operators, set the preset / operators plugin above
            operators = { gc = "Comments" },
            key_labels = {
                -- override the label used to display some keys. It doesn't effect WK in any other way.
                -- For example:
                -- ["<space>"] = "SPC",
                -- ["<cr>"] = "RET",
                -- ["<tab>"] = "TAB",
            },
            icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = "➜", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
            },
            popup_mappings = {
                scroll_down = "<c-d>", -- binding to scroll down inside the popup
                scroll_up = "<c-u>", -- binding to scroll up inside the popup
            },
            window = {
                border = "rounded", -- none, single, double, shadow
                position = "bottom", -- bottom, top
                margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
                padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
                winblend = 0,
            },
            layout = {
                height = { min = 4, max = 20 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 1, -- spacing between columns
                align = "center", -- align columns left, center or right
            },
            ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
            hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
            show_help = true, -- show help message on the command line when the popup is visible
            -- triggers = "auto", -- automatically setup triggers
            -- triggers = {"<leader>"} -- or specify a list manually
            triggers_blacklist = {
                -- list of mode / prefixes that should never be hooked by WhichKey
                -- this is mostly relevant for key maps that start with a native binding
                -- most people should not need to change this
                i = { "j", "k" },
                v = { "j", "k" },
            },
        }

        local opts = {
            mode = "n", -- NORMAL mode
            prefix = "<leader>",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }

        local m_opts = {
            mode = "n", -- NORMAL mode
            prefix = "m",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }


        local mappings = {
            ["0"] = { "<Plug>(cokeline-focus-0)", "Focus 0"},
            ["1"] = { "<Plug>(cokeline-focus-1)", "Focus 1"},
            ["2"] = { "<Plug>(cokeline-focus-2)", "Focus 2"},
            ["3"] = { "<Plug>(cokeline-focus-3)", "Focus 3"},
            ["4"] = { "<Plug>(cokeline-focus-4)", "Focus 4"},
            ["5"] = { "<Plug>(cokeline-focus-5)", "Focus 5"},
            ["6"] = { "<Plug>(cokeline-focus-6)", "Focus 6"},
            ["7"] = { "<Plug>(cokeline-focus-7)", "Focus 7"},
            ["8"] = { "<Plug>(cokeline-focus-8)", "Focus 8"},
            ["9"] = { "<Plug>(cokeline-focus-9)", "Focus 9"},
            B = {
                name = "Bookmarks",
                a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
                c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
                t = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
                m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
                n = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon Toggle" },
                l = { "<cmd>lua require('user.bfs').open()<cr>", "Buffers" },
                j = { "<cmd>silent BookmarkNext<cr>", "Next" },
                s = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },
                k = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
                S = { "<cmd>silent BookmarkShowAll<cr>", "Prev" },
                x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
            },
            c = { "<cmd>nohl<CR>", "Clear search higlighting" },
            d = {
                name = "Debug",
                b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
                c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
                i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
                o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
                O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
                r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
                l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
                x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
                t = {
                    name = "Telescope",
                    c = {"<cmd>lua require'telescope'.extensions.dap.commands{}<CR>", "Telescope"},
                    o = {"<cmd>lua require'telescope'.extensions.dap.configurations{}<CR>", "Telescope"},
                    b = {"<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>", "Telescope"},
                    v = {"<cmd>lua require'telescope'.extensions.dap.variables{}<CR>", "Telescope"},
                    f = {"<cmd>lua require'telescope'.extensions.dap.frames{}<CR>", "Telescope"},
                },
                u = {
                    name = "dap-ui",
                    s = { "<cmd>lua require'dapui'.setup()<cr>", "Setup" },
                    o = { "<cmd>lua require'dapui'.open()<cr>", "Open" },
                    c = { "<cmd>lua require'dapui'.close()<cr>", "Close" },
                    t = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle" },
                },
            },
            D = {
                name = "Documentation",
                d = {"<cmd>lua require'neogen'.generate()<cr>", "Generate  docu"},
            },
            f = {
                name = "Find/Focus",
                b = { "<cmd>Telescope buffers<cr>", "Find in buffers" },
                c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
                d = { "<cmd>Telescope gitmoji<cr>", "Gitmoji" },
                e = { "<cmd>Telescope emoji<cr>", "Emojis" },
                f = { "<cmd>Telescope find_files<cr>", "Find File" },
                g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
                h = { "<cmd>Telescope help_tags<cr>", "Help" },
                i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
                k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
                l = { "<cmd>Telescope resume<cr>", "Last Search" },
                n = { "<Plug>(cokeline-switch-next)", "Focus next"},
                o = { "<cmd>Telescope file_browser<cr>", "Commands" },
                p = { "<Plug>(cokeline-switch-prev)", "Focus preview"},
                r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
                s = { "<cmd>Telescope grep_string theme=ivy<cr>", "Find String" },
                t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
                y = { "<cmd>Telescope symbols<cr>", "Symbols" },
                C = { "<cmd>Telescope commands<cr>", "Commands" },
                M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
                R = { "<cmd>Telescope registers<cr>", "Registers" },
                -- Focus
            },
            g = {
                name = "Git",
                g = { "<cmd>LazyGit<cr>", "Lazygit" },
                j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
                k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
                l = { "<cmd>GitBlameToggle<cr>", "Blame" },
                m = { "<cmd>Telescope gitmoji<cr>", "Git emoji" },
                p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
                r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
                R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
                s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
                u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk", },
                o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
                b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
                c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
                d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff", },
                i = { "<cmd>SidebarNvimToggle<cr>", "Toggle sidebar", },

                G = {
                    name = "Gist",
                    a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
                    d = { "<cmd>Gist -d<cr>", "Delete" },
                    f = { "<cmd>Gist -f<cr>", "Fork" },
                    g = { "<cmd>Gist -b<cr>", "Create" },
                    l = { "<cmd>Gist -l<cr>", "List" },
                    p = { "<cmd>Gist -b -p<cr>", "Create Private" },
                },
            },
            l = {
                name = "LSP",
                a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
                w = {
                    "<cmd>Telescope lsp_workspace_diagnostics<cr>",
                    "Workspace Diagnostics",
                },
                f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
                F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
                d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition"},
                G = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration"},
                i = { "<cmd>LspInfo<cr>", "Info" },
                I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
                h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover"},
                j = {
                    "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
                    "Next Diagnostic",
                },
                k = {
                    "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
                    "Prev Diagnostic",
                },
                K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover"},
                l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
                o = { "<cmd>SymbolsOutline<cr>", "Outline" },
                q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
                r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
                R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
                s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
                S = {
                    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                    "Workspace Symbols",
                },
                t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
                u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
                x = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
            },
            o = {
                name = "Options",
                w = { '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', "Wrap" },
                r = { '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>', "Relative" },
                l = { '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>', "Cursorline" },
                s = { '<cmd>lua require("user.functions").toggle_option("spell")<cr>', "Spell" },
                t = { '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline" },
            },
            p = {
                name = "Lazy",
                c = { "<cmd>Lazy check<cr>", "Check" },
                C = { "<cmd>Lazy clean<cr>", "Clean" },
                i = { "<cmd>Lazy install<cr>", "Install" },
                s = { "<cmd>Lazy sync<cr>", "Sync" },
                u = { "<cmd>Lazy update<cr>", "Update" },
                r = { "<cmd>Lazy restore<cr>", "Restore" },
                l = { "<cmd>Lazy<cr>", "Lazy" },
            },
            r = {
                name = "Rest",
                r = { "<Plug>RestNvim", "Run rest" },
                p = { "<Plug>RestNvimPreview", "Run rest preview" },
                l = { "<Plug>RestNvimLast", "Run rest last" },
            },
            s = {
                name = "Telescope",
                c = { "<cmd>Telescope eomoji<cr>", "Close" },
                f = { "<cmd>%SnipRun<cr>", "Run File" },
                i = { "<cmd>SnipInfo<cr>", "Info" },
                m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
                r = { "<cmd>SnipReset<cr>", "Reset" },
                t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
                x = { "<cmd>SnipTerminate<cr>", "Terminate" },
            },
            S = { "<cmd>w<CR>", "Fast saving"},
            t = {
                name = "Terminal",
                ["1"] = { ":1ToggleTerm<cr>", "1" },
                ["2"] = { ":2ToggleTerm<cr>", "2" },
                ["3"] = { ":3ToggleTerm<cr>", "3" },
                ["4"] = { ":4ToggleTerm<cr>", "4" },
                f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
                h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
                j = { "<cmd>TermExec cmd='gjs %'<cr>", "Execute JavaScript" },
                p = { "<cmd>TermExec cmd='python %'<cr>", "Execute Python" },
                t = { "<cmd> ToggleTerm<cr>", "Open terminal"},
                v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
            },
            T = {
                name = "Treesitter",
                h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
                p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
                r = { "<cmd>TSToggle rainbow<cr>", "Rainbow" },
            },
            u = {
                name = "TodoComments",
                ["t"] = { "<cmd>TodoTelescope<CR>", "Show Comments" },
                ["q"] = { "<cmd>TodoQuickFix<CR>", "Quick Fix" },
                ["l"] = { "<cmd>TodoLocList<CR>", "List Comments" },
            },
            v = {
                name = "Vista",
                o = { "<cmd>:Vista!!<cr>", "Open Tag viewer" },
            },
            w = {
                name = "Window",
                v = { "<C-w>v", "Vertical Split" },
                h = { "<C-w>s", "Horizontal Split" },
                e = { "<C-w>=", "Make Splits Equal" },
                q = { "close<CR>", "Close Split" },
                m = { "MaximizerToggle<CR>", "Toggle Maximizer" },
            },
            x = {
                name = "Trouble",
                x = {"<cmd>Trouble<cr>", "Open Trouble window"},
                w = {"<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics"},
                d = {"<cmd>Trouble document_diagnostics<cr>", "Documents"},
                l = {"<cmd>Trouble loclist<cr>", "List"},
                q = {"<cmd>Trouble quickfix<cr>", "QuickFix"},

            },
            z = {
                name = "Zettelkasten",
                b = {"<cmd>ZkBacklinks<cr>", "Backlinks"},
                h = {"<cmd>lua vim.lsp.buf.hover()<cr>", "Hover"},
                l = {"<cmd>ZkLinks<cr>", "Links"},
                n = {"<cmd>ZkNew { title = vim.fn.input('Título: ') }<cr>", "Nueva nota"},
                o = {"<cmd>ZkNotes<cr>", "Abrir notas"},
                t = {"<cmd>ZkTags<cr>", "Abrir tags"},

            }
        }

        local topts = {
            mode = "t", -- TERMINAL mode
            prefix = "",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }

        local tmappings = {
            ["<C-t>"] = {
                ["1"] = {"<cmd>1ToggleTerm<cr>", "ToggleTerm"},
                ["2"] = {"<cmd>2ToggleTerm<cr>", "ToggleTerm"},
                ["3"] = {"<cmd>3ToggleTerm<cr>", "ToggleTerm"},
                ["4"] = {"<cmd>4ToggleTerm<cr>", "ToggleTerm"},
            },
            ["<esc>"] = {"<cmd>ToggleTerm<cr>", "ToggleTerm"},
            ["<C-h>"] = {"<cmd>wincmd h<cr>", "ToggleTerm"},
            ["<C-j>"] = {"<cmd>wincmd j<cr>", "ToggleTerm"},
            ["<C-k>"] = {"<cmd>wincmd k<cr>", "ToggleTerm"},
            ["<C-l>"] = {"<cmd>wincmd l<cr>", "ToggleTerm"},
            --["<C-t>"] = {"<cmd>ToggleTerm<cr>", "ToggleTerm"},
            ["<C-w>"] = {
                h = { "<C-\\><C-n><C-w>h", "Terminal" },
                j = { "<C-\\><C-n><C-w>j", "Terminal" },
                k = { "<C-\\><C-n><C-w>k", "Terminal" },
                l = { "<C-\\><C-n><C-w>l", "Terminal" },
                ["<C-w>"] = { "<C-\\><C-n><C-w><C-w>", "Terminal" },
            }
        }

        local vopts = {
            mode = "v", -- VISUAL mode
            prefix = "<leader>",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }

        local vmappings = {
            ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
            s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
            z = {
                name = "Zettelkasten",
                a = {":'<,'>lua vim.lsp.buf.range_code_action()<cr>", "Acciones"},
                f = {"<cmd>ZkMatch<cr>", "Abrir por selección"},

            }
        }

        local iopts = {
            mode = "i", -- INSERT mode
            prefix = "",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }

        local imappings = {
            ["<C-h>"] = { "<left>", "Movements"},
            ["<C-j>"] = { "<down>", "Movements"},
            ["<C-k>"] = { "<up>", "Movements"},
            ["<C-l>"] = { "<right>", "Movements"},
        }


        local nopts = {
            mode = "n", -- NORMAL mode
            prefix = "",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }

        local nmappings = {
            ["<C-h>"] = { "<C-w>h", "Movements"},
            ["<C-j>"] = { "<C-w>j", "Movements"},
            ["<C-k>"] = { "<C-w>k", "Movements"},
            ["<C-l>"] = { "<C-w>l", "Movements"},
            ["<C-g>"] = { "<cmd> LazyGit<cr>", "Open LazyGit"},
            ["<C-n>"] = { "<cmd> Neotree toggle<cr>", "Toggle Neotree"},
            ["<C-7>"] = { "<cmd> Telescope command_palette<cr>", "Paleta de comandos"},
            ["<C-q>"] = { "<cmd> Vista!!<cr>", "Vista"},
            ["<C-s>"] = { "<cmd> SidebarNvimToggle<cr>", "Vista"},
            ["<C-t>"] = { "<cmd>ToggleTerm<cr>", "Toggle terminal"},
            ["<bs>"] = { ":edit #<cr>", "Hacia atrás"},
            g = {
                name = "LSP",
                d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition"},
                h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover"},
                i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation"},
                s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature"},
                D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration"},
            },
        }


        which_key.setup(setup)
        which_key.register(mappings, opts)
        which_key.register(vmappings, vopts)
        which_key.register(tmappings, topts)
        which_key.register(imappings, iopts)
        which_key.register(nmappings, nopts)
    end,
}
