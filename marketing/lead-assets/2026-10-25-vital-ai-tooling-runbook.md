# AI Tooling Setup Runbook — Edge-ViT-Acc

This is a one-page starting point for the AI-tooling half of `DomMurphy-git/ViTAl-Hardware#7`. It defines only the files, boundaries, and evidence needed to verify agent work. It does not require credentials.

## Repository structure

```text
prompts_and_logs/
  system/
    coding-agent.md
    literature-agent.md
  templates/
    task-intake.md
    paper-summary.md
    atomic-claim.md
    session-log.md
  sessions/
    2026-10-25-example-session.md
```

The existing Python reference already has a deterministic check:

```sh
python3 base2_softmax.py --self-test
```

## Task intake template

```markdown
# Task
- Goal: Generate or revise one SystemVerilog module / literature note.
- Input files: [list repo paths]
- Desired output: [file path and format]
- Verification: lint, test, simulation, citation check, or compile check
- Allowed tools: [list]
- Stop if: test fails twice, requested path is outside scope, or source is missing.
```

## System prompt boundary

```markdown
You may read only the files listed in the task intake.
You may write only the output file listed in the task intake.
You must show the command used for verification and the actual result.
You must stop after two failed attempts and ask for human review.
You must not invent citations, test results, measurements, or architecture decisions.
```

## Literature note minimum

| Field | Rule |
|---|---|
| Claim | One sentence copied or paraphrased from the source. |
| Evidence | Page, section, equation, or repository path. |
| Confidence | High / medium / low, based on source evidence. |
| Next question | What must be tested or read next? |

## Session log minimum

```markdown
Date:
Agent/tool:
Task intake file:
Prompt summary:
Files read:
Files written:
Verification command:
Actual verification output:
Human correction:
Next action:
```

## First example task

Use `base2_softmax.py` as the first low-risk verification target:

```markdown
# Task
- Goal: Explain or revise one function in `base2_softmax.py`.
- Input files: `base2_softmax.py`
- Desired output: `prompts_and_logs/sessions/2026-10-25-softmax-note.md`
- Verification: `python3 base2_softmax.py --self-test`
- Allowed tools: Python, NumPy, file reader, repository search.
- Stop if: self-test fails twice, requested file is outside `base2_softmax.py`, or the change adds a new dependency.
```

## First verification pass

1. Copy the four templates into `prompts_and_logs/templates/`.
2. Create one example task for a small SystemVerilog edit or paper claim.
3. Run the workflow once and record the actual command and output.
4. If verification fails twice, stop and record the correction in the session log.
5. Commit the templates, example, and log to the private backup repository.

## Paid upgrade path

The free outline can be used directly. A 45-minute setup session would adapt these files to the actual Edge-ViT-Acc folders, run one representative task, and leave the repository-ready version.
