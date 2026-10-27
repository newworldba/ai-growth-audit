#!/usr/bin/env bash
set -euo pipefail

repo="${GROWTHAUDIT_REPO:-newworldba/ai-growth-audit}"
base="${GROWTHAUDIT_BASE_URL:-https://newworldba.github.io/ai-growth-audit}"

printf '%s\n' '--- Sales chain ---'
check_url() {
  local url="$1"
  local expected="$2"
  local body
  body=$(mktemp)
  curl -fsSL --max-time 20 "$url" -o "$body"
  if ! grep -qi "$expected" "$body"; then
    echo "FAIL: $url does not contain '$expected'"
    exit 1
  fi
  echo "OK: $url contains '$expected'"
}

check_url "$base/" "GrowthAudit"
check_url "$base/apply.html" "mailto:hailong.wei@ushow.media"
check_url "$base/payment.html" "支付宝"
check_url "$base/privacy.html" "Privacy Policy"
check_url "$base/terms.html" "Terms of Service"

for qr in alipay-qr.png wechat-qr.png; do
  curl -fsSL --max-time 20 "$base/assets/$qr" -o "/tmp/$qr"
  file "/tmp/$qr" | grep -q "PNG image data" || { echo "FAIL: $base/assets/$qr is not PNG"; exit 1; }
  echo "OK: $base/assets/$qr is reachable PNG"
done

keywords=(
  "GrowthAudit"
  "审计"
  "audit"
  "Founder CRO Kit"
  "转化体检结果"
  "Koody"
  "PDFkind"
  "Grafista"
  "Skillsync"
  "AI Workflow Fix"
  "AI 工作流修复"
  "workflow"
  "工作流"
  "Client status draft"
  "client status update"
  "Payment confirmation"
  "payment"
  "paid"
  "receipt"
  "invoice"
  "付款"
  "支付"
  "收款"
  "发票"
  "支付宝"
  "微信支付"
)

printf '%s\n' '--- GitHub Issues ---'
gh issue list --repo "$repo" --state open --limit 20 \
  --json number,title,author,createdAt,labels,url \
  --template '{{range .}}#{{.number}} | {{.title}} | {{.author.login}} | {{.createdAt}} | {{range .labels}}{{.name}} {{end}}{{"\n"}}{{end}}'

printf '%s\n' '--- Mail inbox matches ---'
osascript <<'OSA'
on run argv
  set keywordList to argv
  tell application "Mail"
    set output to ""
    repeat with accountItem in accounts
      repeat with mailboxItem in mailboxes
        if name of mailboxItem is "INBOX" then
          try
            set matchedMessages to {}
            repeat with keywordItem in keywordList
              set matchedMessages to matchedMessages & (messages of mailboxItem whose subject contains keywordItem)
            end repeat
            if (count of matchedMessages) > 0 then
              set output to output & "ACCOUNT:" & (name of accountItem) & " | MATCHES:" & (count of matchedMessages) & linefeed
              repeat with messageItem in matchedMessages
                set output to output & "DATE:" & (date received of messageItem) & " | FROM:" & (sender of messageItem) & " | SUBJECT:" & (subject of messageItem) & linefeed
              end repeat
            end if
          end try
        end if
      end repeat
    end repeat
    if output is "" then set output to "NO_MATCHES"
    return output
  end tell
end run
OSA
