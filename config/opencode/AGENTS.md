# Agent Rules

## Precedence
- If the repo has a project `AGENTS.md`, follow it as the source of truth.
- If there are multiple `AGENTS.md` files, follow the closest one to the files being changed.

## `@path` references (manual lazy loading)
When you see `@path/to/file.md`:
- Use the Read tool to load it only if it is relevant to the current task.
- Treat loaded content as mandatory instructions that override defaults.
- Do not bulk-load `@` references; load on demand.

## Confirmation gates (required)
Get explicit user confirmation before proceeding when:
- Scope is ambiguous (what/where/how much).
- The action is destructive/irreversible (deletes, migrations, force ops).
- The change is wide-impact (auto-fix, mass formatting, large refactors).
- The change affects security/auth/secrets, billing, deployments, or production behavior.

When confirming, present:
- Goal + assumptions
- Proposed plan (steps, commands, files)
- Risks + rollback notes
Do not perform edits/auto-fix until confirmed.

## Commands (discover, don’t guess)
Prefer repo-defined commands. If unclear, look for:
- README / AGENTS.md
- `package.json` scripts / Makefile / justfile / task config
- CI workflows
If still unclear, ask for the exact command rather than inventing one.

## Coding style + formatting workflow (required before code edits or auto-fix)
Trigger this before editing code or running any formatter/linter with write/fix.

### 1) Discover repo style/tooling (minimum relevant reads)
Always check if present:
- `.editorconfig`

Then read only what matches the language/tooling in scope:
- JS/TS: `package.json`, `biome.json*`, `.prettierrc*`, `prettier.config.*`, `eslint.config.*`, `.eslintrc*`, `tsconfig.json`
- Python: `pyproject.toml`, `ruff.toml`/`.ruff.toml`, `setup.cfg`, `tox.ini`
- Go: `go.mod`, `.golangci.*`
- Rust: `Cargo.toml`, `rustfmt.toml`/`.rustfmt.toml`, `clippy.toml`
- Lua: `stylua.toml`/`.stylua.toml`
- Shell: `.shfmt`, `.shellcheckrc`
- C/C++: `.clang-format`

Extract only what affects edits:
indentation, line length, quotes, trailing commas, import ordering, formatter-of-record, lint strictness.

### 2) Discover editor formatting behavior (personal, single source)
If formatting behavior/args matter, read:
- `~/.config/nvim/lua/plugins/lsp/lspconfig.lua`

Also check for repo-local codesettings files (read only if present and relevant):
- `.vscode/settings.json`
- `codesettings.json`, `lspsettings.json`
- `.codesettings.json`, `.lspsettings.json`
- `.nvim/codesettings.json`, `.nvim/lspsettings.json`

Extract only:
- Conform: `formatters_by_ft`, formatter args/append_args, `default_format_opts`, `format_on_save`
- LSP formatting-related settings that can change outcomes (per-server):
  - formatter enable/disable flags (e.g. `format.enable`)
  - server-provided formatting toggles (e.g. `provideFormatter`, wrap/max width options)
- Repo-local codesettings overrides (if present): per-server formatting toggles or format options that affect edits
Do not scan other editor config files unless explicitly needed.

### 3) Resolve conflicts
- Prefer repo config for project changes.
- If editor behavior/args conflict with repo config, call it out and ask which should win for this repo.

### 4) Present and confirm
Before editing any files or running auto-fix, present:

Detected style
- Sources:
- Formatter/linter of record:
- Key rules:
- Editor formatting notes (if relevant):

Proposed plan
- Steps (ordered):
- Commands (if any):
- Files to change:
- Wide-impact actions:

Ask the user to confirm (or provide overrides). Do not proceed until confirmed.

## Project memory (after approval only)
After the user confirms style + plan, persist repo-specific conventions in:
- `.opencode/rules/coding-style.md`

If the repo already has `AGENTS.md`, add a pointer like:
- `@.opencode/rules/coding-style.md`

If the repo does not have `AGENTS.md`, recommend running `/init` so the project can adopt the `@` pointer and make the memory discoverable.

## Boundaries
Always:
- Keep diffs minimal and aligned with the repo’s style/tooling.
- Prefer existing patterns and nearby examples over inventing new ones.

Ask first:
- Adding dependencies, changing CI/build/test, mass formatting/auto-fix, touching infra/prod.

Never:
- Commit/push unless explicitly asked.
- Copy secrets/tokens from any config files.
- Edit vendor/generated outputs unless explicitly requested.
