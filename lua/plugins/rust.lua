return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "rust", "ron" } },
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				rust_analyzer = {
					mason = false, -- use rust-analyzer from the rustup toolchain
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								buildScripts = {
									enable = true,
								},
							},
							-- clippy on save (replaces the removed checkOnSave option)
							check = {
								command = "clippy",
							},
							procMacro = {
								enable = true,
							},
							files = {
								exclude = {
									".direnv",
									".git",
									".jj",
									".github",
									".gitlab",
									"bin",
									"node_modules",
									"target",
									"venv",
									".venv",
								},
								-- Avoid the "Roots Scanned" hang
								-- https://github.com/rust-lang/rust-analyzer/issues/12613
								watcher = "client",
							},
						},
					},
				},
			},
		},
	},
}
