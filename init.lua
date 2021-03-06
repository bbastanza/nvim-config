require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.cmp")
require("user.lsp")
require("user.telescope")
require("user.treesitter")
require("user.autopairs")
require("user.comment")
require("user.gitsigns")
require("user.nvim-tree")
require("user.bufferline")
require("user.lualine")
require("user.toggleterm")
require("user.project")
require("user.impatient")
require("user.indentline")
require("user.alpha")
require("user.whichkey")
require("user.autocommands")
require("user.ftimproved")
require("user.lightbulb")
require("user.unittests")
require("user.colorscheme")
require("user.lsp.null-ls")

require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/angular" } }

require 'lspconfig'.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
    end,
}
