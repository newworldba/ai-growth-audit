#!/usr/bin/env bash
set -euo pipefail

repo="${GROWTHAUDIT_REPO:-newworldba/ai-growth-audit}"
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
