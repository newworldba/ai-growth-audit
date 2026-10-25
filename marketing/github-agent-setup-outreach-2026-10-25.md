# GitHub outreach drafts: AI Agent setup help

Date: 2026-10-25  
Rule: send one issue comment at a time after explicit user approval. Do not mass-comment, reuse unrelated templates, claim clients, or promise income.

## 1. suirindo/agent-role-contracts #37

**Issue:** https://github.com/suirindo/agent-role-contracts/issues/37  
**Fit:** The maintainer explicitly asks for feedback on evaluating a real AI-agent workflow, including handoff boundaries and controls.

```markdown
I can share a one-page evaluation outline for one real workflow: task inputs, reviewer role, allowed tools, deliberate out-of-scope case, approval gate, and evidence fields. It will stay within your public-data boundary and will not grant runtime authority.

The useful part is the mismatch checklist: what the declaration says, what the runtime allows, what the reviewer verifies, and what stops automation when evidence is incomplete. I can post the outline here if useful.
```

## 2. DomMurphy-git/ViTAl-Hardware #7

**Issue:** https://github.com/DomMurphy-git/ViTAl-Hardware/issues/7  
**Fit:** The issue asks for an Obsidian vault, verification/reproducibility rules, prompts, logs, and AI-tool tracking—close to a 45-minute setup session.

```markdown
For the AI tooling half, I would define four reusable files first: a task intake template, a prompts-and-logs format, a verification checklist, and a permissions/boundary note. The vault then has one place per task to answer: input, allowed source, desired output, review step, and when the agent must stop.

I can outline that as a short runbook tied to your Obsidian folder structure. It stays repo-local and does not require granting credentials.
```

## 3. JonatanGarbuyo/agents-workflow #1

**Issue:** https://github.com/JonatanGarbuyo/agents-workflow/issues/1  
**Fit:** The project needs a repeatable handoff/runbook for Agents/OpenCode/GitHub Actions with explicit recovery and approval boundaries.

```markdown
One lightweight addition that may help the remaining pilot: a one-page handoff runbook with fields for task contract, permitted workspace paths, execution runner, evidence artifacts, failure count, reviewer output, and resume-from state. It would make the Actions ↔ OpenCode handoff auditable without turning conversation transcripts into the source of truth.

I can draft that as a markdown template you can adapt to the existing ADR and JSON handoff schema.
```

## Offer link

- Chinese service page: https://newworldba.github.io/ai-growth-audit/zh/agent-setup.html
- English service page: https://newworldba.github.io/ai-growth-audit/agent-setup.html
- Do not post the offer link unless the maintainer asks for help or the comment needs context.
