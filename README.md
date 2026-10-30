# Neovim configuration

Personal Neovim configuration built on NvChad v2.5 and lazy.nvim.
Requires Neovim 0.11+ and Git. Start Neovim to install plugins; versions are
recorded in `lazy-lock.json`. Language servers must be installed separately
(on PATH or through `:Mason`).

## Layout

- `init.lua`: bootstrap lazy.nvim, load NvChad, theme, options, and mappings.
- `lua/plugins/`: focused plugin specs, imported automatically by lazy.nvim.
- `lua/configs/`: plugin settings and shared diagnostic preferences.
- `lua/configs/lspconfig.lua`: shared NvChad LSP setup and enabled server list.
- `lua/configs/lsp/`: custom server settings, one module per server.
- `lua/options.lua`, `lua/mappings.lua`: editor behavior and key bindings.
- `lua/chadrc.lua`, `lua/custom/highlights.lua`: theme and UI customization.
- `scripts/`: headless verification commands.

For a server using stock nvim-lspconfig settings, add its name to `servers` in
`lua/configs/lspconfig.lua`. For custom settings, add a module under
`lua/configs/lsp/` returning a configuration table, then add its name to the
custom server loop. Keep plugin declarations separate from server settings.

`lua/plugins/benzene.lua` is an optional local plugin; it only loads when its
configured checkout exists.

## Rust

Install Rust through Rustup, then install these components:

```sh
rustup component add rust-analyzer rust-src
```

Restart Neovim and open a `.rs` file inside a Cargo project. `rust_analyzer`
starts automatically using nvim-lspconfig's Cargo workspace detection. The
configuration prefers Rustup's server and adds `CARGO_HOME/bin` (or
`~/.cargo/bin`) to Neovim's PATH so the server can find Cargo and rustc even
when the launching terminal has an old PATH. If no Rustup executable exists,
it uses `rust-analyzer` from PATH, including Mason's bin directory.

Use `:checkhealth vim.lsp` to inspect enabled servers and `:lua
vim.print(vim.lsp.get_clients({ bufnr = 0 }))` to inspect attached clients.
NvChad's LSP mappings include `gd` for definition and `<leader>ra` for rename;
Neovim provides `K` for hover.

Run the real Rust attachment check from this directory:

```sh
nvim --headless -u ./init.lua -l scripts/check-rust-lsp.lua
```

It creates a temporary Cargo project, opens its Rust source with this config,
checks that rust-analyzer initializes and attaches, and removes the fixture.
It needs installed plugins, Rust components, and write access to Neovim's
normal data directory. A failed attachment produces a nonzero exit code.
