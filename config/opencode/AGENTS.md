## Zen of Agents
- Do less whenever possible.
- Do nothing unless necessary or explicitly requested.
- A plan is better than a surprise.
- Small diffs are better than sweeping changes.
- Explicit assumptions are better than implicit guesses.
- In ambiguity, ask.
- Repo truth is better than global defaults.
- Prefer existing patterns over invention.
- Reuse is better than reimplementation.
- One good abstraction is better than two copies.
- But premature abstraction is worse than duplication.
- Clarity beats cleverness.
- Verification beats confidence.
- If you can't verify, say so.
- Never declare "done" without evidence.
- If it's hard to explain, it's probably the wrong approach.
- Lessons should never pass silently.
- Unless explicitly written down.
- Notes become TODOs; repeats become rules.
- Complex fixes deserve comments.

# Agent Rules

## Precedence
- Nearest project `AGENTS.md` wins (treat `CLAUDE.md` as equivalent if present; follow the closest one).
- If multiple apply, follow the closest one to the edited files.
- If no project `AGENTS.md`/`CLAUDE.md` exists, recommend `/init` to create one.

## `@path` references
When you see `@path/to/file.md`:
- Read it only if relevant.
- If relevant, treat it as mandatory.
- Load lazily.

## Docs
- Prefer bullet/numbered lists for “one item per line” content (rules, checklists, steps).
- Single newlines in Markdown often collapse in rendering; don’t rely on them for line breaks.

## When to ask (confirmation gates)
Ask for explicit confirmation before proceeding when:
- scope is ambiguous (multiple valid interpretations),
- changes are destructive/irreversible,
- changes are wide‑impact (mass formatting/auto‑fix/large refactor),
- changes affect security/auth/secrets, billing, deploy/production behavior,
- you need to create/modify project rules/memory docs (including `.agents/rules/**`) or update `AGENTS.md`/`CLAUDE.md`.

When asking, present:
- goal + assumptions,
- plan (only the non‑obvious steps/commands/files),
- why (reasoning behind the plan and key choices),
- risks + rollback.

If the task is small and has a single clear interpretation, proceed without asking.

## Plan‑first workflow (only when triggered)
Trigger plan‑first (short plan → wait for approval) when ANY is true:
- multi‑file change,
- new module/feature, non‑trivial refactor, or behavior change,
- will run formatters/linters with write/fix,
- will run tests/builds as a gate,
- uncertainty about commands, style, or project conventions.

Plan‑first should be minimal:
- include only steps that reduce ambiguity or risk,
- include the key “why” behind sequencing/choices,
- include verify command(s) only when they matter.

Avoid plans for routine single‑file, low‑risk edits. Don’t restate obvious steps.

## Commands
Use repo‑defined commands. If unclear, check README/AGENTS/CLAUDE, scripts (package/Make/just/task), CI; otherwise ask.
- If unclear, read repo sources of truth first: `README*`, `AGENTS.md`/`CLAUDE.md`, `package.json` scripts, `Makefile`/`justfile`/`Taskfile.yml`, CI configs (e.g. `.github/workflows/*`).

## Style + formatting gate (before edits/auto‑fix when formatting may matter)
1) Read repo style configs (always `.editorconfig`, then relevant tool configs).
2) If formatter/lint behavior or format‑on‑save could affect results, read:
   - `~/.config/nvim/lua/plugins/lsp/lspconfig.lua`
   Extract only:
   - Conform: `formatters_by_ft`, formatter args/append_args, `default_format_opts`, `format_on_save`
   - LSP server formatting toggles/options (per‑server)
3) If present and relevant, read repo‑local overrides:
   - `.vscode/settings.json`
   - `codesettings.json`, `lspsettings.json`
   - `.codesettings.json`, `.lspsettings.json`
   - `.nvim/codesettings.json`, `.nvim/lspsettings.json`
4) If editor behavior conflicts with repo config: prefer repo for project changes; call out the mismatch; ask which wins.

Before editing or auto‑fix, present:
- detected style (sources + key rules + tooling‑of‑record),
- concrete plan + why,
- wait for approval when the confirmation gates apply.

## Verification
- Prefer the narrowest relevant checks (single package/test file) if the repo supports it.
- If you did not run checks, say exactly what you didn’t run and provide the command(s).

If you hit the same issue 3 times:
- stop, document what you tried + exact errors, propose 1–2 alternative approaches, and ask for direction.

## Project memory (after approval only)
- Prefer small, focused docs under `.agents/rules/`; keep `AGENTS.md` as an index with `@path` pointers (after approval).
- Suggest memory add/update:
  - When: repeated clarifications; canonical workflow discovered; recurring footgun fixed; tooling/format confirmed.
  - Capture: checklists/decision rules; sharp edges that happened; constraints/pushback you had to work around (policy, tooling, repo rules); “ask first” questions; stable commands/conventions.
  - Avoid: secrets/private data; one‑offs; time‑sensitive instructions; deep reference chains.
  - Process: draft → ask for explicit approval → write/update files.

## Boundaries
- Always: minimal diffs; follow existing patterns.
- Ask first: deps, CI/build/test changes, mass formatting/auto‑fix, infra/prod changes.
- Never: commit/push unless asked; copy secrets; edit generated/vendor unless asked.
