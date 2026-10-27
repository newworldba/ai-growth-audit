#!/usr/bin/env bash
set -euo pipefail

echo "=== Agent-accessible Superteam Earn listings ==="
curl -L -fsS 'https://superteam.fun/api/listings?status=open' \
  -H 'accept: application/json' \
  -H 'user-agent: Mozilla/5.0' |
  jq -r '
    .[]
    | select(.status == "OPEN" and (.agentAccess == "AGENT_ALLOWED" or .agentAccess == "AGENT_ONLY"))
    | [.rewardAmount, .token, .agentAccess, .deadline, .title, "https://superteam.fun/earn/listing/" + .slug]
    | @tsv' || true

echo "=== Agent Bounties no-spend claimables ==="
curl -L -fsS --max-time 20 \
  'https://api.agentbounties.app/v1/base/autonomous-bounties/feed?network=base-mainnet&status=claimable' \
  -H 'accept: application/json' |
  jq -r '[.[] | select(.status == "claimable" and .required_external_spend == "0")
    | {
        title: .terms.document.title,
        id: .bounty_id,
        reward_usdc: ((.solver_reward | tonumber) / 1000000),
        bond_usdc: ((.claim_bond | tonumber) / 1000000),
        verification_ready,
        reason: .verification_readiness_reason
      }]
    | sort_by(-.reward_usdc)[]
    | [.reward_usdc, .bond_usdc, .verification_ready, .title, .id, .reason]
    | @tsv' || true

echo "=== Highest-value unclaimed POIDH bounties ==="
curl -L -fsS --max-time 20 'https://poidh.xyz/bounties/data?limit=100' \
  -H 'accept: application/json' \
  -H 'user-agent: Mozilla/5.0' |
  jq -r '.items[]
    | select(.hasClaims == false and .isCanceled == false and .isVoting == false)
    | [.priceUsd, .chainId, .title, .url]
    | @tsv' || true

echo "=== Highest-value recent GitHub bounty issues ==="
gh search issues 'BOUNTY "$" state:open' --limit 100 \
  --json repository,number,title,state,url,createdAt,commentsCount \
  --jq '
  .[]
  | select(.state == "OPEN" and .commentsCount <= 2)
  | select(.repository.nameWithOwner | test("bounty-bot|bounty-plaza|BountyScout|bounty-watcher|earn-ops|agentmidasopendevteam"; "i") | not)
  | select(.title | test("\\$[0-9]"))
  | [.repository.nameWithOwner, .number, .title, .url, .createdAt, .commentsCount]
  | @tsv'
