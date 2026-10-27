# GitHub outreach drafts: AI Agent setup help

Date: 2026-10-25  
Rule: send one issue comment at a time after explicit user approval. Do not mass-comment, reuse unrelated templates, claim clients, or promise income.

## 1. suirindo/agent-role-contracts #37

**Issue:** https://github.com/suirindo/agent-role-contracts/issues/37  
**Fit:** The maintainer explicitly asks for feedback on evaluating a real AI-agent workflow, including handoff boundaries and controls.

```markdown
`Agent/workflow: scoped code change | Mismatch: task contract permits writing the requested module, but the runtime allow-list can still include unrelated paths and the reviewer may only see the final diff | Existing control: diff review, unless the allow-list is checked at dispatch and the verification command/result is attached.`

I can turn this into a four-point checklist with a deliberate out-of-scope case and evidence fields if useful.
```

## 2. DomMurphy-git/ViTAl-Hardware #7

**Issue:** https://github.com/DomMurphy-git/ViTAl-Hardware/issues/7  
**Fit:** The issue asks for an Obsidian vault, verification/reproducibility rules, prompts, logs, and AI-tool tracking—close to a 45-minute setup session.

```markdown
For the AI-tooling half, start with four repo-local files: task intake, system prompt, session log, and literature/claim template. The intake should record input paths, desired output path, verification command, allowed tools, and the exact stop rule.

I can turn that into a short runbook tied to your proposed Obsidian folders—no credentials needed.
```

## 3. JonatanGarbuyo/agents-workflow #1

**Issue:** https://github.com/JonatanGarbuyo/agents-workflow/issues/1  
**Fit:** The project needs a repeatable handoff/runbook for Agents/OpenCode/GitHub Actions with explicit recovery and approval boundaries.

```markdown
For the Actions ↔ OpenCode pilot, a one-page handoff runbook may make the resume path easier to audit: task contract, permitted paths, runner, evidence artifacts, failure count, reviewer output, and resume-from state.

Want a markdown template that fits the existing ADR and JSON handoff schema?
```

## 4. lightspeedwp/.github #2734

**Issue:** https://github.com/lightspeedwp/.github/issues/2734
**Fit:** The issue explicitly requests discoverable quick starts, troubleshooting, and a maintainer runbook for issue/PR management agents with safety gates.

```markdown
A useful first draft is a one-page runbook with five blocks: quick start, config boundaries, dry-run command, audit-log locations, and disable/escalate path. Each block should name the exact file, script, or command and what a reviewer must verify before letting the agent touch labels, reviewers, or milestones.

Want a markdown template for that first draft?
```

## Priority

1. `DomMurphy-git/ViTAl-Hardware#7` — direct setup request and a tailored free sample is ready.
2. `suirindo/agent-role-contracts#37` — active maintainer conversation and a one-line mismatch answer is ready.
3. `lightspeedwp/.github#2734` — explicit runbook/documentation request.
4. `JonatanGarbuyo/agents-workflow#1` — useful but repository implementation is still early.

## Offer link

- Chinese service page: https://newworldba.github.io/ai-growth-audit/zh/agent-setup.html
- English service page: https://newworldba.github.io/ai-growth-audit/agent-setup.html
- Do not post the offer link unless the maintainer asks for help or the comment needs context.
