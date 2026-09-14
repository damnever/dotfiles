# Neovim configuration

## Search and find

The map leader is `,`. Press `,k` to search configured keymaps by key or description. It includes Normal, Insert, Command, Visual, Operator-pending, and Terminal mappings while hiding internal `<Plug>` mappings. Search-related descriptions include the words `Search` or `Find`, so either term reveals the relevant shortcuts.

| Shortcut | Scope | Search behavior |
| --- | --- | --- |
| `,k` | Current Neovim session | Search keymaps in all modes |
| `,p` | Current working directory | Find files with `rg --files`, including hidden files except `.git` |
| `,P` | File history | Find recent and frequently used files with Telescope Frecency |
| Visual `,g` | Current working directory | Search for the selected text with `rg` |
| `,G` | Current working directory | Search text live with `rg` and optional arguments such as `--iglob` |
| `,B` | Current buffer | Search lines with fuzzy matching |
| `,S` | Current buffer | Search functions, variables, and other symbols using Treesitter |
| `,s` | Current buffer | Search symbols in the persistent Outline panel |
| `,<Space>` | Neovim commands | Search and run available commands |
| `,h` | Command history | Search and rerun previous commands |
| `,cp` | Clipboard history | Search clipboard and macro entries |

Treesitter symbol search understands syntax rather than matching raw text. It can distinguish functions, variables, and other symbol kinds without depending on an LSP server. It requires a parser and a `locals` query for the current filetype; when either is unavailable, `,S` falls back to fuzzy text search in the current buffer. Inside a Telescope picker, press `?` in Normal mode to see the picker's own keymaps and descriptions.

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

The test opens valid Go, Python, Swift, Bash, TypeScript, Markdown, and Lua fixtures in one headless Neovim process. It verifies filetype detection, Tree-sitter attachment and symbol queries, the configured language server where applicable, saving through the normal editor configuration, search-keymap descriptions, notification rendering, and the absence of error notifications or messages. A second headless process verifies that Telescope Frecency and its `,P` keymap are available, and that `,S` opens Treesitter symbol search for code and falls back to current-buffer text search for Markdown.

Test caches and state live in a temporary directory and are removed afterward, so the run does not reuse the normal Neovim cache or the Telescope frecency database.
