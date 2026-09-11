# Neovim configuration

## Update dependencies

Run the update script from any directory:

```sh
~/.config/nvim/scripts/update
```

The script runs Lazy's headless sync, updates every installed Tree-sitter parser, refreshes the Mason registry, installs the required `black` formatter, and updates every installed Mason package. It updates Neovim-managed dependencies only; it does not update Neovim itself or system toolchains such as Go, Python, Swift, and Node.js.

Lazy follows the constraints in each plugin specification. Before running the script, review exact version pins and move them to the intended release when necessary:

```sh
rg 'version =|branch =' ~/.config/nvim/lua/plugins
```

For example, `version = "0.2.1"` remains on that exact release until the configuration changes, while a branch such as `v3.x` continues to its latest commit.

Set `NVIM_BIN` to test another Neovim executable:

```sh
NVIM_BIN=/path/to/nvim ~/.config/nvim/scripts/update
```

## Run smoke tests

```sh
~/.config/nvim/scripts/test
```

The test opens valid Go, Python, Swift, Bash, TypeScript, Markdown, and Lua fixtures in one headless Neovim process. It verifies filetype detection, Tree-sitter attachment, the configured language server where applicable, saving through the normal editor configuration, notification rendering, and the absence of error notifications or messages.

Test caches and state live in a temporary directory and are removed afterward, so the run does not reuse the normal Neovim cache or the Telescope frecency database.
