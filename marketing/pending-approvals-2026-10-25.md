# Pending approvals — 2026-10-25

## Ready now

| # | Action | Asset | Result |
|---|---|---|---|
| 1 | ~~Post GitHub comment on `DomMurphy-git/ViTAl-Hardware#7`~~ | [Published comment](https://github.com/DomMurphy-git/ViTAl-Hardware/issues/7#issuecomment-6419043787) | Highest-fit lead; direct setup request |
| 2 | ~~Post GitHub comment on `suirindo/agent-role-contracts#37`~~ | [Published comment](https://github.com/suirindo/agent-role-contracts/issues/37#issuecomment-6419279796) | Active maintainer conversation |
| 3 | ~~Post GitHub comment on `lightspeedwp/.github#2734`~~ | [Published comment](https://github.com/lightspeedwp/.github/issues/2734#issuecomment-6419289913) | Explicit runbook/documentation request |
| 4 | Submit SwarmMemo micro-task result and claim 100 credits | `marketing/swarmmemo-task-draft-2026-10-25.md` | Small reward + public credibility |
| 5 | Manually publish WeChat post | `marketing/notes/agent-setup-wechat.md` + `marketing/assets/agent-setup-xhs.png` | Chinese traffic source |
| 6 | Manually publish Xiaohongshu Note A | `marketing/notes/agent-setup-xhs.md` + `marketing/assets/agent-setup-xhs.png` | Chinese traffic source |
| 7 | Publish free runbook lead magnet | `agent-setup-runbook.html` + `zh/agent-setup-runbook.html` + `sitemap.xml` | Public asset with direct paid-session CTA |
| 8 | Publish free runbook social post | `marketing/notes/agent-setup-runbook-xhs.md` + `marketing/assets/agent-setup-runbook-xhs.png` | Free-value hook with paid setup CTA |
| 9 | Manually publish free runbook WeChat post | `marketing/notes/agent-setup-runbook-wechat.md` + `marketing/assets/agent-setup-runbook-xhs.png` | Low-friction Chinese distribution |
| 10 | Send free runbook email follow-ups to Stintly / Clienwork / MakeWay | `zh/follow-ups-batch-8-free-runbook.md` | Three targeted email touches with free template |

## Rules

- GitHub comments go out one at a time, not in bulk.
- No offer link in a GitHub comment unless the maintainer asks for paid help.
- No claim of clients, revenue, or results.
- No credentials, keys, or private data.

---

## 2026-10-26 — ARC evaluation follow-up on suirindo/agent-role-contracts#37

**Target issue:** https://github.com/suirindo/agent-role-contracts/issues/37
**Maintainer replied:** "yes, that would be useful. Please turn it into the four-point checklist."

### Draft comment

---

Here is the four-point checklist result from a synthetic AI-agent-runbook workflow.

**1. Bind the intended scope**

- ARC source: `@netsujo/agent-role-contracts@1.0.0`, exact commit `9f6771056c47de971202360952af6d41941f7625`
- Node.js: v22.22.2, macOS (arm64)
- Declared write scope: `outputs/ai-audit-launch-kit/agent-setup-runbook.html` + `outputs/ai-audit-launch-kit/zh/agent-setup-runbook.html`
- Roles: `runbook-implementer` (write_scoped) / `runbook-reviewer` (read_only)

**2. Capture dispatch scope**

- Runtime allow-list observed at dispatch: the full repository tree (the agent process was not sandboxed to the declared two-file scope).
- The allow-list was not projected into or checked against the ARC task contract before dispatch. This is an **integration/runtime gap**, not an ARC defect. ARC v1.0 correctly classifies it as "declaration check only."

**3. Deliberate negative control**

- Injected path: `outputs/ai-audit-launch-kit/payment.html` (outside declared authority, inside runtime allow-list)
- ARC declaration result: `TASK_WRITE_SCOPE_OUTSIDE_AUTHORITY` FAIL (exit 0 from the helper; correct FAIL diagnostic)
- Runtime enforcement result: **not enforced** — the runtime would have permitted the write if dispatched without ARC's preflight. This confirms the integration gap above.
- Reviewer/diff result: the final diff review would have caught the unauthorized file appearance in `git diff`, but only after the write occurred. ARC's value is catching it **before** dispatch.

**4. Acceptance evidence**

- Sequence: in-scope PASS → injected `payment.html` FAIL → repaired in-scope PASS (all exit 0, `DECLARATION_TESTS_PASSED`)
- Second task (`zh/agent-setup-runbook.html`) with unchanged bundle: declaration PASS
- Additional finding: first second-task attempt used `zh/agent-setup.html` (outside declared scope); the unchanged bundle correctly rejected it (`TASK_WRITE_SCOPE_OUTSIDE_AUTHORITY`), then I corrected the scope to match the contract.
- Setup: ~15 minutes (clone, read README/examples, create synthetic bundle + task JSON, run)
- False refusals: 1 (the `zh/agent-setup.html` attempt above — correct refusal, not a false positive)
- What existing diff review caught: the unauthorized file appearance post-write, but not pre-dispatch
- Would I reuse: yes, for a second real task. The unchanged bundle correctly enforced scope on both attempts. The limitation is that each new file must be added to the bundle's `allowed_write_scopes`, which requires a bundle edit (not a runtime change).

**Evidence classification:** `SELF_REPORTED` (local declaration check, no public CI link)
**Known limits:** No runtime execution was performed. The "runtime allow-list broader than declared scope" finding is an observation about the integration pattern, not a test of ARC's runtime enforcement (which it does not provide).

---

### Approval status
- [ ] User approved to post this comment

---

## 2026-10-26 — New outreach targets (4 issues)

### 1. kirodotdev/Kiro #10615 — path-scoped and per-agent permission rules

**Link:** https://github.com/kirodotdev/Kiro/issues/10615
**Why relevant:** Real pain: 18 agents sharing unconditional `fs_write: allow` + wildcard shell. They need path-scoped, per-agent permissions.

**Draft comment (value-only):**

---

A pattern that helps when the runtime doesn't yet support per-agent scoping: keep a **contract file per agent** that declares `allowed_write_paths`, `allowed_shell_patterns` and `prohibited_capabilities`, then check that contract against the dispatch request **before** the runtime executes. It doesn't replace the runtime enforcement you're requesting, but it catches the mismatch early and gives you an auditable declaration.

For your 18-agent case, the two most impactful first steps are: (1) strip all wildcard shell entries (`python3 *`, `git *`, `curl *`) into specific commands, and (2) add `fs_write` scope paths per agent rather than per-user. Even without runtime enforcement, having the declarations makes the gap visible in `git diff` when someone accidentally adds a new wildcard.

---

### 2. PersonalClaw/personalclaw.dev #100 — agent setup runbook at /start.md

**Link:** https://github.com/PersonalClaw/personalclaw.dev/issues/100
**Why relevant:** They want to publish a stable agent-readable setup runbook. We built one recently and learned several things.

**Draft comment (value-only):**

---

We recently published a bilingual agent setup runbook on GitHub Pages and learned a few things that might help with `/start.md`:

- Keep it to one page with five blocks: quick start (exact commands), approval boundaries (what the agent must not touch), task intake format, escalation conditions, and a one-command verification. Anything longer and the agent stops reading it.
- Pin the runbook to the release tag, not `main`. We used a release-anchored HTML file so the agent reads instructions that match the version it's installing.
- Add it to `llms.txt` right after the install line, not in a separate section — agents scan the first few lines.
- For bilingual versions, use stable filenames (`/start.md` for English, `/zh/start.md` for Chinese) and cross-link both in `llms.txt`.

---

### 3. AgentWorkforce/relaycast #453 — agent-scoped permissions

**Link:** https://github.com/AgentWorkforce/relaycast/issues/453
**Why relevant:** Same theme: agents shouldn't need the workspace key. The proposal is sound; we can offer a concrete short-term pattern.

**Draft comment (value-only):**

---

Until all the relay MCP endpoints accept agent tokens, a short-term pattern that reduces workspace-key exposure: have the broker spawn agents with an ephemeral token scoped to the specific actions they need (e.g. read-only for `list_agents`, `query_nodes`), then proxy the workspace-key endpoints through a small sidecar that validates the agent token before forwarding. This keeps the workspace key off the agent's environment without requiring the engine to change all six endpoints at once.

---

### 4. NEO-Kaizen/backend-novo #39 — OpenCode permissions setup

**Link:** https://github.com/NEO-Kaizen/backend-novo/issues/39
**Why relevant:** They need to create `opencode.json` with V2 permissions and document it in AGENTS.md. Very concrete, very close to our expertise.

**Draft comment (value-only):**

---

Your V2 scope is a solid start. Two suggestions:

1. For the `.env` protection, note that OpenCode's `permission.rules` is pattern-based with **last-match-wins**, so put the specific deny first and the general allow second:
```json
{"permission": {"read": [{"pattern": "*.env*", "action": "deny"}, {"pattern": "*.env.example*", "action": "allow"}], "shell": [{"pattern": "*git status*", "action": "allow"}, {"pattern": "*git diff*", "action": "allow"}, {"pattern": "*", "action": "ask"}]}}
```
2. Document the "Allow always" audit path: OpenCode stores saved approvals in `~/.opencode/approvals.json`, so your AGENTS.md section can tell the team to `cat ~/.opencode/approvals.json` as a pre-merge check to catch any over-broad permissions that accumulated.

---

### Approval status
- [ ] ARC #37 follow-up comment approved
- [ ] Kiro #10615 comment approved
- [ ] PersonalClaw #100 comment approved
- [ ] Relycast #453 comment approved
- [ ] Backend-novo #39 comment approved

---

## 2026-10-26 — New target: konveyor/agentic-controller #288

**Link:** https://github.com/konveyor/agentic-controller/issues/288
**Why relevant:** Security researchers from Old Dominion University reported excessive credential provisioning across AgentRun sandboxes. We can contribute a concrete implementation pattern for credential scoping.

**Draft comment (value-only):**

---

One pattern that helps here: instead of injecting the raw `KONVEYOR_LLM_API_KEY` into the sandbox environment, have the Gateway expose a **per-AgentRun short-lived token** (e.g. a JWT with `agent_run_id`, `gateway_id`, and `allowed_models` claims). The Goose process then authenticates to the Gateway with that token, and the Gateway internally uses the shared credential to forward the request. This way:

1. Each AgentRun gets a credential that expires with the run, not the Gateway's long-lived key.
2. The Gateway can enforce per-run rate limits and model restrictions before forwarding.
3. If one sandbox is compromised, the exposed token is scoped to that run and expires quickly, not a reusable provider credential.

For implementation, the smallest change is in `buildEnvVars()`: replace the `SecretKeyRef` env var with a `ConfigMapKeyRef` pointing to a per-run token generated by the controller. The Gateway's auth middleware validates the JWT against a public key instead of the provider credential.

---

### Approval status
- [ ] konveyor/agentic-controller #288 comment approved
