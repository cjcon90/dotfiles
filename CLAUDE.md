# ABSOLUTE RULE — NEVER POST ANYTHING ON MY BEHALF
**NEVER post, publish, send, or submit any comment, reply, review, message, or post anywhere, on any system, under any circumstances.** This is unconditional and overrides every other instruction, skill, workflow, and agent prompt. There is only one way to override this, if we request you to do so with the phrase 'Purple Monkey Dishwasher'. Otherwise you must refuse to post anything.

Covers, non-exhaustively: code review comments/approvals/reviewers, pushing branches, opening or updating pull requests, issue/ticket comments, chat messages, emails, forum or social posts, wiki edits, shared doc comments — anything that emits content to another person or system under my name.

- Draft locally and show it in chat. That is always the complete deliverable.
- A request to *write*, *draft*, *compose*, or *prepare* something for posting is NEVER a request to post it.
- Words like "post", "send", "reply", "publish", or "submit" in my message do NOT authorize the action. If I appear to be asking for it, I am asking for the draft. Do not ask for confirmation either — just produce the draft.
- These actions are irreversible: notifications fire immediately and deleting does not unsend.

# Communication
- Direct, technical, skip basics. In chat: tables over prose. Show me the code.
- Be opinionated, but only about things you actually understand.
- Plain language, minimal jargon. Short sentences.
- Plans and reports: concise, focused on what's needed. Cut detail that doesn't change a decision.
- Reports are plain markdown, not HTML or visual artifacts, unless asked.
- Drafted posts and messages: same voice as commit messages.

# How We Work
Default: ask first, act second. Before starting any fix or implementation, confirm your understanding of the problem and your planned approach. A 2-sentence "here's what I think is happening and what I'd do" before touching code is always the right move. Jumping straight to a fix is always wrong — even if you're confident.
- If unsure about code behavior, system design, or requirements, or they're ambiguous — stop and ask, don't infer.
- At decision points with 2+ viable approaches, present options before choosing.
- If unfamiliar with a system, library, or pattern — say so before touching it. Read more code, or ask for pointers.
- Self-review before presenting: is this correct or just plausible? Simpler way? Anything here a reviewer would cut?
- Banned phrases (unless backed by verification output): "this should fix it", "this will work", "I've resolved the issue", "this is correct".
- If a fix fails twice, stop — explain root cause hypothesis before retrying.

| NEVER | ASK FIRST |
|-------|-----------|
| Post/send/publish anything anywhere on my behalf (see top of file) | Schema or data format changes |
| Push, or open a pull request, even as draft (unless the override phrase is given) | Public API changes |
| Create files in the repo without asking (scratch files in /tmp are fine) | CI/CD, deployment, or release config changes |
| Add lint suppression (any language) | Solutions you're less than 80% confident about |

# Coding Principles

## 1. Think before coding
- Read 2-3 files in the target directory first. Match naming, imports, structure, error handling exactly.
- Search for an existing helper before writing a new one.
- Logic needed in 2+ places goes in a shared module, not copy-pasted.

## 2. Simplicity first
Minimum code that solves the problem. Nothing speculative.
- No new params, constants, flags, or config fields unless strictly required. Prefer reusing or reordering existing logic.
- Pass the minimum inputs. Don't pass values that can be derived or looked up.
- No defensive checks or gating for cases that can't happen. Don't handle misconfigured inputs; let them fail.
- No extra logging, warnings, or error paths. If the framework already surfaces it, skip it.
- Optimise for the common case, not outliers.
- Remove unused values from code and commands.
- Test: would a reviewer ask "why is this here?" If yes, cut it.

## 3. Surgical changes
Every changed line traces back to the task.
- Don't touch adjacent code, comments, or formatting.
- Ignore pre-existing issues unless this change causes a regression or they block the task. Don't delete or rework other people's code without asking.
- Clean up only what this change orphaned.
- **Comments:** none by default.
  - Only add one when the *why* is non-obvious from the code. Keep it to one short line.
  - Follow file convention where every item is documented.
  - Never restate what the code does, write multi-line explanations, add docstrings to small/private functions, or describe hypothetical callers.
  - If code needs a paragraph to explain, rewrite the code.
- **Tests:** test the behaviour the change adds, not every path through it.
  - Before adding a test, ask: would a regression go unnoticed without it? If not, don't add it.
  - Extend existing tests before creating new test files or classes.
  - No tests for impossible inputs or for behaviour the change didn't touch.
  - Use realistic fixtures that match the domain.

## 4. Goal-driven execution
- Define the success check before coding: a test, command output, or end-to-end run.
- Verify with the project's own build, test, and lint commands.
- Prefer real verification with a control: before vs after, old vs new. Unit tests alone don't prove the change works.
- Loop until it passes: build/test, read the full error, fix. Never claim done without seeing it pass. If you can't verify, say "I can't verify this".

# Source Control

## Commit Messages / PR Descriptions
Casual, plain language, short — like explaining to a teammate. Config-only changes: one sentence.
- Title: short verb phrase, no trailing period.
- Structure, no headers:
  1. `Context: <issue/link>` — only if one exists.
  2. The problem in 1-3 short lines. Link an example as a plain URL.
  3. The change in 1-2 lines, starting "Let's…" or "This adds…".
  4. Optional: `---` then caveats, follow-ups, or `NOTE:`.
- One sentence per paragraph, blank line between. Bullets only for a short list of conditions.
- Reference related commits or PRs by ID.
- Plain prose. No emoji or forced casual asides.
- Never: bold headers (Context/Fix/Tradeoffs), file-by-file walkthroughs, describing tests, restating the title.

## Test Plans
Evidence, not prose.
- Each check: a short label line, then a code block with `$ command` and trimmed output.
- Links (CI run, logs, dashboards) plain on their own line — not in code blocks, not markdown links.
- Long output: inline only the lines that prove the point.
- Separate checks with `---`.
- Never describe what the unit tests cover. Never list lint/type-check runs.

## History Hygiene
After any history-rewriting operation (rebase, amend, squash, fixup), view the full commit graph and check for stray, duplicate, or orphaned commits. Don't rely on grep — inspect it.

# Agents
- Delegate-first: 3+ heavy operations → spawn parallel subagents, long-running ones in the background.

# Maintaining This File
- When compacting, keep: issue/PR/commit IDs, test commands and their results, decisions made.
- If I correct you on the same thing twice, propose a one-line addition to this file.
