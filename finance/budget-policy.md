# Startup Budget Policy

## Current Budget

- Available: CNY 209.96
- Spent: CNY 0
- Remaining: CNY 209.96

## Spending Rules

1. Do not spend unless the purchase directly removes a blocker to delivering or collecting revenue.
2. Keep at least CNY 100 uncommitted until the first CNY 199 product sale or CNY 1,080 service payment is received.
3. Buy only one core asset at a time. Do not stack domain, hosting, database, cache, load balancer, Kubernetes, monitoring, premium DNS, or paid email until revenue justifies each layer.
4. Prefer free tiers and existing assets first: GitHub Pages, browser-only tools, GitHub Issues, manual payment confirmation, and current email address.
5. Before buying infrastructure, write the expected monthly recurring cost, the revenue trigger, and the rollback plan.

## Purchase Gates

| Asset | Trigger before purchase | Budget rule |
|---|---|---:|
| Domain | A named launch or outbound campaign needs a memorable root domain; the expected first-year cost is below CNY 100. | Single purchase, not stacked with hosting. |
| Premium DNS | Existing DNS cannot provide required records or uptime. | Only after domain and site have organic/referred traffic. |
| Hosting | GitHub Pages cannot run required server logic or reliability is blocking delivery. | Prefer serverless or client-side logic first. |
| Database | The product needs durable cross-device records or automated delivery that manual files cannot support. | Use the smallest managed free tier. |
| Cache | Measured traffic causes performance or rate-limit problems. | Do not buy for theoretical scale. |
| Load balancer | There are multiple production origins or measured availability issues. | Avoid until recurring revenue exists. |
| Kubernetes / ACK | A workload cannot run reliably on simpler managed hosting. | Avoid while revenue is below CNY 3,000/month. |
| Monitoring | Payment or delivery failures are occurring and logs/manual checks are insufficient. | Start with free uptime and workflow alerts. |
| Paid email | Delivery, sending volume, or reputation is blocked by the current mailbox. | Try the current mailbox and reply-to workflows first. |

## Current Decision

Do not buy additional infrastructure now. Keep the current free GitHub Pages site and manual payment workflow. Use available time for conversion-page improvements, public examples, and confirmed outreach.
