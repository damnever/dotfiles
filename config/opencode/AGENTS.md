# Agent Rules

## Zen of Agents (TLDR)

- Do less whenever possible.
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

Non-negotiable: end every reply with "着力即差".


## Precedence
- Nearest project `AGENTS.md` wins (treat `CLAUDE.md` as equivalent if present; follow the closest one).
- If multiple apply, follow the closest one to the edited files.
- If no project `AGENTS.md`/`CLAUDE.md` exists, recommend `/init` to create one.

## `@path` references
When you see `@path/to/file.md`:
- Read it only if relevant.
- If relevant, treat it as mandatory.
- Load lazily.

## Plan-first and approval gates

Default: **execute without asking**.

If any gate triggers, **pause before execution**:
- If the environment/tool supports **Plan Mode**, switch to it and present **Plan-first**.
- Otherwise, present **Plan-first** and ask for explicit approval.

**No-confirm-spam rule:** once the user approves the Plan-first for the current task, execute end-to-end without re-asking. Re-ask only if you uncover a **new, gate-triggering risk** not covered in the approved plan.

### Gates (trigger Plan-first → wait for approval)

A) **Ambiguity**
- Multiple plausible interpretations with meaningfully different outcomes, and repo context does not disambiguate.

B) **Destructive / hard-to-reverse**
- Data loss or hard-to-undo ops (delete/overwrite, history rewrite, destructive migrations, force operations).

C) **Shared/external side effects**
- Visible to others or affects shared systems (push/merge, commenting/filing issues, modifying shared infra or external services).

D) **Production / billing / security blast radius**
- Changes deploy/runtime behavior, customer-visible behavior, SLO/on-call risk, cost drivers, or security boundaries (authn/authz, secrets, keys, tokens, certificates, encryption).
- Exception: clearly safe additive changes (docs/comments, inert defaults, non-sensitive config additions) may proceed.

E) **Wide-impact edits (thresholded)**
- Exceeds threshold, e.g. touching **>10 files** OR changing **>400 lines** OR running auto-fix/formatters across directories.
- (Adjust thresholds per repo; prefer smaller thresholds in high-risk repos.)

F) **Modifying agent governance**
- Creating/changing instruction/governance docs (`.agents/rules/**`, `AGENTS.md`, `CLAUDE.md`, equivalents).
- Exception: explicitly requested **typo/format-only** edits that do not change meaning.

G) **Non-trivial behavior change**
- New module/feature, non-trivial refactor, or any behavior change whose correctness can’t be inferred mechanically.
- Exception: small mechanical edits may proceed (rename/symbol-only, doc/comment-only, localized fix within one subsystem and below thresholds).

### Plan-first format (scaled by change size)

If the change is tiny (e.g., <=1 file AND <=50 LOC AND no behavior change):
- Goal: …
- Patch:
  - Area/Subsystems/Files: …
  - Diff: (full unified diff)
- Validation: … (what you ran; or say not run + exact commands)
(Omit everything else.)

Otherwise use headings below; keep it short.

#### Context (minimal by default)
- Background: … (only what’s needed)
- Goal: … (what “done” means)
- Assumptions: … (only decision-driving)

(Add Non-goals / Constraints only when needed.)

#### Proposed Approach (high level)
- Summary: … (strategy)
- Key decisions: … (if applicable)
- Alternatives considered: … (if applicable)

#### Scoped Changes (scoped, diff-aligned)
- Step-by-step operations, grouped by **component/file scope** (one scope at a time), in execution order.
- For each scope: list the steps, then include the **matching unified diff** immediately under that scope (no cross-scope or orphan diffs).

#### Risks / Rollback / Validation
- Risks: … (only if applicable)
- Rollback: … (only if applicable)
- Validation: … (what you ran; if not run, say so + exact commands)

Rule: Omit sections that are not applicable; do not add filler.

## Style + formatting preflight

Goal: avoid accidental formatting/auto-import diffs by aligning repo style + (Neovim) editor behavior.

Run this preflight before any edits when formatting may matter:
- editing code (not just docs/comments), OR
- format-on-save / auto-imports could affect the file types touched, OR
- you might run formatters/linters in write/fix mode.

Preflight steps (always, in this order):
1) Read formatting behavior + project-local editor overrides:
   - `~/.config/nvim/lua/plugins/lsp/lspconfig.lua`
   - repo-local overrides if present (treat as project-scoped inputs):
     - `.vscode/settings.json`
     - `codesettings.json`, `lspsettings.json`
     - `.codesettings.json`, `.lspsettings.json`
     - `.nvim/codesettings.json`, `.nvim/lspsettings.json`
   Extract only:
   - Conform: `formatters_by_ft`, formatter args/append_args, `default_format_opts`, `format_on_save`
   - per-server LSP formatting toggles/options
   - any repo override that changes formatter selection, format-on-save, or code actions on save

2) Read repo style configs (always):
   - `.editorconfig`
   - then relevant formatter/linter configs for the languages touched

3) If editor behavior conflicts with repo config:
   - prefer repo config for project changes;
   - call out the mismatch briefly (what differs + which setting wins);
   - ask which wins only if it would materially change the diff.

Approval behavior:
- Preflight itself does not require confirmation.
- Only stop for approval when the Plan-first gates apply (e.g., repo-wide formatting exceeds thresholds).

## Verification
- Prefer the narrowest relevant checks (single package/test file) when supported.
- Always state what you ran. If you did not run checks, state exactly what you didn’t run and provide the command(s).

## Boundaries
- Always: minimal diffs; follow existing patterns.
- Ask first (Plan-first gates apply): deps; CI/build/test pipeline changes; repo-wide formatting/auto-fix; infra/prod changes; security/auth/secrets; billing/cost drivers.
- Never (unless explicitly asked): commit/push/merge; paste/exfiltrate secrets; edit generated/vendor artifacts.

## Project memory (after approval only)
- Prefer small, focused docs under `.agents/rules/`; keep `AGENTS.md` as an index with `@path` pointers (after approval).
- Suggest memory add/update:
  - When: repeated clarifications; canonical workflow discovered; recurring footgun fixed; tooling/format confirmed.
  - Capture: checklists/decision rules; sharp edges that happened; constraints/pushback you had to work around (policy, tooling, repo rules); “ask first” questions; stable commands/conventions.
  - Avoid: secrets/private data; one‑offs; time‑sensitive instructions; deep reference chains.
  - Process: draft → ask for explicit approval → write/update files.

## If stuck (e.g., same issue 3 times)
Stop and write:
- what you tried (commands/edits),
- exact errors,
- 1–2 alternative approaches,
- what you need from the user to proceed.