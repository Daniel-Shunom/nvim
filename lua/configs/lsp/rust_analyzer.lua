-- Rustup installs tools in CARGO_HOME/bin, which an existing terminal may
-- not have on PATH yet. Also make cargo/rustc available to the server.
local cargo_home = vim.env.CARGO_HOME or (vim.fn.expand "~" .. "/.cargo")
local cargo_bin = cargo_home .. "/bin"
local separator = vim.fn.has "win32" == 1 and ";" or ":"
local executable = cargo_bin .. "/rust-analyzer" .. (vim.fn.has "win32" == 1 and ".exe" or "")
if vim.fn.executable(executable) == 1 then
  local paths = vim.split(vim.env.PATH or "", separator, { plain = true })
  if not vim.tbl_contains(paths, cargo_bin) then
    vim.env.PATH = cargo_bin .. separator .. (vim.env.PATH or "")
  end
end

return {
  cmd = { vim.fn.executable(executable) == 1 and executable or "rust-analyzer" },
}
