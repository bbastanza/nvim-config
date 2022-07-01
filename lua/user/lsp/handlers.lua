local M = {}

-- TODO: backfill this to template
M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "⮚ ",

        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = true,
        signs = true,
    })

    vim.cmd([[
        augroup _diagnostics
            autocmd!
            autocmd CursorHold * lua vim.diagnostic.open_float()
            autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()
        augroup end
    ]])

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    local status_ok, illuminate = pcall(require, "illuminate")

    if not status_ok then
        return
    end
    illuminate.on_attach(client)
    -- end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", ":lua vim.lsp.buf.hover()<CR>", opts)
    -- Implementations
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi",
        ":lua require'telescope.builtin'.lsp_implementations(require('telescope.themes').get_dropdown())<CR>"
        , opts)
    -- Search Symbols
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs",
        ":lua require'telescope.builtin'.lsp_dynamic_workspace_symbols(require('telescope.themes').get_dropdown())<CR>"
        , opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-i>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-r>", ":lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", ':lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", ':lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>d", ":lua vim.diagnostic.setloclist()<CR>", opts)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

local ignoreFormattingServers = {
    "tsserver",
    "jsonls"
}

local function serverIgnoreFormatting(serverName)
    for _, name in ipairs(ignoreFormattingServers) do
        if name == serverName then
            return true
        end
    end

    return false
end

M.on_attach = function(client, bufnr)
    vim.notify(client.name .. " starting...")
    -- TODO: refactor this into a method that checks if string in list
    -- if client.name == "tsserver" then
    --     client.server_capabilities.document_formatting = false
    -- end
    -- if client.name == "jsonls" then
    --     client.server_capabilities.document_formatting = false
    -- end

    if (not serverIgnoreFormatting(client.name)) then
        vim.cmd([[
            augroup _format
                autocmd!
                 autocmd BufWritePre * lua vim.lsp.buf.formatting()
        
            augroup end
        ]])
    end

    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
