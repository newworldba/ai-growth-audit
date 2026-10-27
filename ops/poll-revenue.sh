#!/usr/bin/env bash
set -euo pipefail

echo "=== Local agent fingerprint ==="
agent_fingerprint=${1:-$(python3 - <<'PY'
import hashlib
import importlib.util
import pathlib

script = pathlib.Path.home() / ".swarmmemo" / "swarmmemo.py"
spec = importlib.util.spec_from_file_location("swarmmemo", script)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
key = module.load_key(pathlib.Path.home() / ".swarmmemo" / "key.json")
print(hashlib.sha256(module.public_bytes(key)).hexdigest())
PY
)}
echo "$agent_fingerprint"

echo "=== SwarmMemo home actions ==="
python3 - <<'PY'
import importlib.util
import json
import pathlib

script = pathlib.Path.home() / ".swarmmemo" / "swarmmemo.py"
spec = importlib.util.spec_from_file_location("swarmmemo", script)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
client = module.Client(key=module.load_key(pathlib.Path.home() / ".swarmmemo" / "key.json"))
result = client.home()
items = result.get("data", {}).get("items", [])
print(json.dumps({"nothing_needs_you": result.get("data", {}).get("nothing_needs_you"), "items": items}, ensure_ascii=False, indent=2))
PY

echo "=== SwarmMemo paid calls ==="
python3 - <<'PY'
import importlib.util
import json
import pathlib

script = pathlib.Path.home() / ".swarmmemo" / "swarmmemo.py"
spec = importlib.util.spec_from_file_location("swarmmemo", script)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
client = module.Client(key=module.load_key(pathlib.Path.home() / ".swarmmemo" / "key.json"))
result = client.offering_calls(kind="open", limit=50)
print(json.dumps(result, ensure_ascii=False, indent=2))
PY

echo "=== SwarmMemo eligible tasks ==="
python3 "$HOME/.swarmmemo/swarmmemo.py" --key "$HOME/.swarmmemo/key.json" \
  work list --kind earn --eligible-for "$agent_fingerprint" --limit 100 |
  jq '{claimable: [.data.works[] | select(.claimable == true)] | length, works: [.data.works[] | select(.claimable == true) | {id, title, reward, standing}]}'

echo "=== SwarmMemo trust ==="
python3 "$HOME/.swarmmemo/swarmmemo.py" --key "$HOME/.swarmmemo/key.json" trust "$agent_fingerprint" |
  jq '{standing:.data.standing, climb:.data.climb, world:.data.world}'

echo "=== llms.txt Hub PRs ==="
gh pr view 2201 -R thedaviddias/llms-txt-hub \
  --json number,title,state,mergeable,mergedAt,headRefOid,comments,reviews,statusCheckRollup \
  --jq '{number,title,state,mergeable,mergedAt,headRefOid,comments:(.comments|length),reviews:[.reviews[]?|{author:.author.login,state}],checks:[.statusCheckRollup[]?|{name,status,conclusion}]}'

echo "=== GitPay PRs ==="
for pr in 1641 1642 1643; do
  gh pr view "$pr" -R worknenjoy/gitpay \
    --json number,title,state,mergeable,comments,reviews,statusCheckRollup \
    --jq '{number,title,state,mergeable,comments:(.comments|length),reviews:(.reviews|length),checks:[.statusCheckRollup[]? | {name,status,conclusion}]}'
done

echo "=== Paraloom PRs ==="
gh pr view 141 -R paraloom-labs/paraloom-wallet \
  --json number,title,state,mergeable,comments,reviews,statusCheckRollup \
  --jq '{number,title,state,mergeable,comments:(.comments|length),reviews:(.reviews|length),checks:[.statusCheckRollup[]? | {name,status,conclusion}]}'

echo "=== Claude Builders Bounty PRs ==="
for pr in 5073 5074 5075; do
  gh pr view "$pr" -R claude-builders-bounty/claude-builders-bounty \
    --json number,title,state,mergeable,mergedAt,author,comments,reviews,statusCheckRollup \
    --jq '{number,title,state,mergeable,mergedAt,author:.author.login,comments:(.comments|length),reviews:(.reviews|length),checks:[.statusCheckRollup[]? | {name,status,conclusion}]}'
done
