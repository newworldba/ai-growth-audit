#!/usr/bin/env bash
set -euo pipefail

ops_dir="$(cd "$(dirname "$0")" && pwd)"
snapshot_dir="${ops_dir}/evidence/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$snapshot_dir"

poll_status=OK
scan_status=OK
bash "$ops_dir/poll-revenue.sh" >"$snapshot_dir/poll.txt" 2>&1 || poll_status=FAIL
bash "$ops_dir/scan-cash-bounties.sh" >"$snapshot_dir/scan.txt" 2>&1 || scan_status=FAIL

cat >"$snapshot_dir/summary.txt" <<EOF
timestamp: $(date -u +%Y-%m-%dT%H:%M:%SZ)
poll_status: $poll_status
scan_status: $scan_status
snapshot: $snapshot_dir
EOF

cat "$snapshot_dir/summary.txt"
