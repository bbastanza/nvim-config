vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _lightbulb
    autocmd!
    autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
  augroup end

    augroup _diagnostics
        autocmd!
        autocmd CursorHold * lua vim.diagnostic.open_float()
        autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()
    augroup end
]])

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
        local luasnip = require "luasnip"
        if luasnip.expand_or_jumpable() then
            -- ask maintainer for option to make this silent
            luasnip.unlink_current()
        end
    end,
})
-- " augroup _showDiagnostics
-- "   autocmd!
-- "   autocmd BufWritePre * :lua vim.diagnostic.open_float()
-- " augroup end

-- augroup _lsp
-- autocmd!
-- autocmd BufWritePre * lua vim.lsp.buff.format({""})
-- augroup end
-- Autoformat
