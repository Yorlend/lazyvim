return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "cpp" } },
	},
	{
		"p00f/clangd_extensions.nvim",
		enabled = false, -- Re-enable when switching back to clangd
		lazy = true,
		config = function() end,
		opts = {
			inlay_hints = {
				inline = false,
			},
			ast = {
				--These require codicons (https://github.com/microsoft/vscode-codicons)
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					specifier = "",
					statement = "",
					["template argument"] = "",
				},
				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clice = {
					keys = {
						{
							"<leader>ch",
							function()
								local bufnr = vim.api.nvim_get_current_buf()
								local client = vim.lsp.get_clients({ bufnr = bufnr, name = "clice" })[1]
								if not client then
									return vim.notify("clice is not attached", vim.log.levels.WARN)
								end
								client:request("clice/counterparts", { uri = vim.uri_from_bufnr(bufnr) }, function(err, result)
									if err then
										return vim.notify(err.message, vim.log.levels.ERROR)
									end
									local function open(uri)
										vim.cmd.edit(vim.fn.fnameescape(vim.uri_to_fname(uri)))
									end
									if result and result.preferred and result.preferred ~= vim.NIL then
										return open(result.preferred)
									end
									local candidates = result and result.candidates or {}
									if #candidates == 0 then
										return vim.notify("No matching header/source found", vim.log.levels.INFO)
									end
									vim.ui.select(candidates, {
										prompt = "Switch Source/Header",
										format_item = function(item)
											return vim.fn.fnamemodify(vim.uri_to_fname(item.uri), ":~:.")
										end,
									}, function(choice)
										if choice then
											open(choice.uri)
										end
									end)
								end, bufnr)
							end,
							desc = "Switch Source/Header (C/C++)",
						},
					},
					mason = false, -- Use clice from PATH
					cmd = { "clice", "serve" },
					filetypes = { "c", "cpp", "cuda" },
					root_markers = { "clice.toml", "compile_commands.json", ".git" },
					on_init = function(client)
						-- Request full semantic tokens to avoid potentially corrupted delta updates.
						local provider = client.server_capabilities.semanticTokensProvider
						if type(provider) == "table" and type(provider.full) == "table" then
							provider.full.delta = false
						end
					end,
				},
				clangd = {
					enabled = false,
					keys = {
						{ "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
					},
					root_markers = {
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac", -- AutoTools
						"Makefile",
						"configure.ac",
						"configure.in",
						"config.h.in",
						"meson.build",
						"meson_options.txt",
						"build.ninja",
						".git",
					},
					capabilities = {
						offsetEncoding = { "utf-16" },
					},
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
			},
			setup = {
				clangd = function(_, opts)
					local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
					require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
					return false
				end,
			},
		},
	},
	{
		-- Ensure C/C++ debugger is installed
		"mason-org/mason.nvim",
		optional = true,
	},
}
