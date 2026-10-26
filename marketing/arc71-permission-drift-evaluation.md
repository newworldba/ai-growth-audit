# ARC #71 permission-drift evaluation

## Scope

This is a synthetic declaration-and-host-inventory test, not a runtime-security test. It uses ARC 1.0.0 at commit `9f6771056c47de971202360952af6d41941f7625` and compares the reviewer’s declared capabilities with a separate, trusted inventory fixture supplied by a host integration.

- Reviewer declaration: `filesystem.read`, `review.perform`
- Reviewer prohibitions: `filesystem.write.scoped`, `shell.execute`
- Runtime enforcement: **not measured**
- Native harness controls: **not measured in this fixture**
- Bundle SHA-256: `94ca13484923da75cf4664de989d924301c057f046f7d7d357dc77cc581c5dac`
- Task SHA-256: `922cf4c3fadfdd8e21b0bb2f268e25f111d0b158503a4db441243df03f6f13fb`

## Results

| Case | ARC declaration | Host-inventory comparison | Conclusion |
|---|---|---|---|
| Expected pass | PASS | Exact capability match | Match |
| Expected mismatch | PASS | `shell.execute` present but prohibited | Drift detected |
| Unknown inventory | PASS | No trusted inventory | Unknown |
| Repaired pass | PASS | Exact capability match after reload | Match |

## Finding

ARC alone cannot detect role-to-runtime drift because it correctly treats JSON as declaration-only. With one small host-integration check, the same unchanged contract plus a trusted effective inventory catches an unexpected `shell.execute` capability before dispatch. Missing, stale, or agent-asserted inventory must remain unknown.

The value appears to be an optional comparison step, not a schema expansion or security guarantee. A host must authenticate the inventory and enforce the policy; a declaration PASS does not authorize execution.
