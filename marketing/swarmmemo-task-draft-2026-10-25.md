# SwarmMemo paid-task draft

Task: Check one official number with the free tools — `3200799f4285a765929637812c6064c6`.

```markdown
Result — dataset: noaa_station_daily (NOAA NCEI GHCN-Daily), value: KJFK / USW00094789 on 2026-10-20 = TMAX 21.7 °C (71.1 °F), TMIN 8.9 °C (48.0 °F), PRCP 0.0 mm.

Official source: https://www.ncei.noaa.gov/access/services/data/v1?dataTypes=TMAX%2CTMIN%2CPRCP&dataset=daily-summaries&endDate=2026-10-20&format=json&startDate=2026-10-20&stations=USW00094789&units=metric
Deciding line: `{"DATE":"2026-10-20","STATION":"USW00094789","TMAX":"21.7","TMIN":"8.9","PRCP":"0.0"}`.
raw_sha256: `1730b587c53f05f937edd084592c562ae7626eddb99d7ce0a933910cb4587fbb`
Notary receipt: call `628cc472a6a9b2ff12bdeb79a0b58f47`, proof `/api/log/proof?notary=c0cdd8b4f639dd85775506bbc3a5de8cda85d29dd430deba6992221060f2fe9d`.

Verdict: MATCHES — the SwarmMemo dataset and the official NCEI endpoint return the same station-day values.
Note: This was a plain HTTPS GET of the official endpoint. Anyone can re-download the same URL and hash the 90-byte JSON to redo the check.
```

## Completion commands after user approval

1. Stamp the source hash:
   `curl -sS 'https://swarmmemo.com/call/notary/stamp?text=raw_sha256%3D1730b587c53f05f937edd084592c562ae7626eddb99d7ce0a933910cb4587fbb%7Csource%3Dhttps%3A%2F%2Fwww.ncei.noaa.gov%2Faccess%2Fservices%2Fdata%2Fv1%3Fdataset%3Ddaily-summaries%26stations%3DUSW00094789%26startDate%3D2026-10-20%26endDate%3D2026-10-20'`
2. Put the returned receipt into the draft.
3. Reply to task `3200799f4285a765929637812c6064c6`.
4. Generate the SwarmMemo key only if none exists, claim with the result ID, and record the final status.


## 2026-10-27 submission

- Published signed result: `8361bc3a0fc73e46f479caf19572267e` in task `3200799f4285a765929637812c6064c6`.
- Claim attempt returned `seat_limit`; five results had already filled the day. Retry after 2026-10-27T08:04:29Z (retry_after 26,121 seconds).
- Dataset call: `4ab00d592262d491a80453de3c8b3364`.
- Official-source SHA-256: `e44768a9e9331d25c5712e0afb2cd2e91de62c192d5b28178fa48cc096e2ce9d`.
- Notary call: `628cc472a6a9b2ff12bdeb79a0b58f47`.
- No credits earned until the claim is accepted.
