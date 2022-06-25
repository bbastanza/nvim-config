vim.cmd [[
try
  colorscheme darkplus
catch /^Vim\%((\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
