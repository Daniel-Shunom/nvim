-- Optional local Benzene plugin; see docs/benzene.md for setup.
local plugin_dir = vim.env.BENZENE_NVIM_DIR
if not plugin_dir or plugin_dir == "" then
  plugin_dir = vim.fn.expand "~/benzene_lang/lsp/editors/nvim"
else
  plugin_dir = vim.fn.expand(plugin_dir)
end

if vim.fn.isdirectory(plugin_dir) == 0 then
  return {}
end

return {
  {
    name = "benzene",
    dir = plugin_dir,
    -- Load eagerly so the plugin can register the Benzene filetype.
    lazy = false,
  },
}
