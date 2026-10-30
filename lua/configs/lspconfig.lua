-- Common NvChad capabilities, keymaps, and Lua server defaults.
require("nvchad.configs.lspconfig").defaults()
require "configs.diagnostics"

-- Servers using nvim-lspconfig defaults need only an entry here.
local servers = {
  "html", "cssls", "bashls", "pyright", "gleam", "erlang_ls", "cmake",
  "tailwindcss", "hls",
}

-- Servers with custom settings live in their own modules.
for _, name in ipairs { "ts_ls", "clangd", "rust_analyzer" } do
  vim.lsp.config(name, require("configs.lsp." .. name))
  servers[#servers + 1] = name
end
vim.lsp.enable(servers)
