-- Run with: nvim --headless -u ./init.lua -l scripts/check-rust-lsp.lua
local root = vim.fn.tempname()
vim.fn.mkdir(root .. "/src", "p")
vim.fn.writefile({ '[package]', 'name = "nvim_lsp_check"', 'version = "0.1.0"', 'edition = "2021"' }, root .. "/Cargo.toml")
vim.fn.writefile({ 'fn main() { println!("Rust LSP check"); }' }, root .. "/src/main.rs")
vim.cmd.edit(root .. "/src/main.rs")
local attached = vim.wait(15000, function()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0, name = "rust_analyzer" })) do
    if client.initialized then
      return true
    end
  end
  return false
end, 100)
print("RUST_LSP_ATTACHED=" .. tostring(attached))
print("RUST_ANALYZER_PATH=" .. vim.fn.exepath("rust-analyzer"))
vim.fn.delete(root, "rf")
vim.cmd(attached and "qa!" or "cquit 1")
