local status_ok, dap = pcall(require, "dap")
if not status_ok then
    return
end

dap.adapters.coreclr = {
    type = 'executable',
    command = '/path/to/dotnet/netcoredbg/netcoredbg',
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    },
}
