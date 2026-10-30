# Benzene support

The optional local plugin provides filetype detection, syntax highlighting,
and the ether-lsp language server for `.bz` files. Its implementation lives in
the `benzene_lang` repository on the `feat-lsp` branch. This Neovim repository
only declares the plugin; it does not duplicate the plugin's LSP setup.

## Checkout location

By default, `lua/plugins/benzene.lua` looks for the plugin at
`~/benzene_lang/lsp/editors/nvim`.

For a different checkout location, set `BENZENE_NVIM_DIR` to the plugin
directory before starting Neovim. In PowerShell:

```powershell
$env:BENZENE_NVIM_DIR = "D:/projects/benzene_lang/lsp/editors/nvim"
nvim
```

This environment variable applies to the current shell and its child
processes. Set it in your shell profile or user environment for persistence.
An unset or empty variable uses the default location. If the chosen directory
does not exist, the plugin is skipped without affecting Neovim startup.

## Build and verify

From the `benzene_lang` checkout, run both build steps in PowerShell:

```powershell
.\build.bat
.\lsp\build.cmd
```

`build.bat` builds `bin/ether.exe`, which performs the analysis.
`lsp/build.cmd` builds the language server; repeat it after changing the server.

Restart Neovim, open a `.bz` file, and run `:BenzeneLspStatus` to check whether
the server attached.

The plugin loads eagerly because its filetype detection rules define the
`benzene` filetype. Loading it only on that filetype would prevent those rules
from being registered. The server itself starts only when a Benzene buffer
opens.

## Experimental status

The existing plugin was mostly AI-generated in one pass and has not been
reviewed. If it causes problems, temporarily set `BENZENE_NVIM_DIR` to a
nonexistent directory before starting Neovim to disable it.
