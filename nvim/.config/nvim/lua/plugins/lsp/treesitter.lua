return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = { "c", "lua", },
		-- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		-- auto_install = true,
		--
		-- List of parsers to ignore installing (or "all")
		-- ignore_install = { "javascript" },
		-- highlight = { enable = true },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn", -- set to `false` to disable one of the mappings
				node_incremental = "gnn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
	}
	-- TODO: folding
}
