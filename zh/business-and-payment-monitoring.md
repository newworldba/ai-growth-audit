# 业务和支付确认流程

更新时间：2026-10-21  
适用产品：48 小时审计、Growth Audit、Implementation Sprint、Founder CRO Kit。

## 一、知道业务来了

打开 [收入监控台](ops-monitor.html) 可以集中查看本机支付记录。命令行检查请运行：

```bash
scripts/check-business.sh
```

当前有三个入口：

1. 邮件回复：`hailong.wei@ushow.media`。
2. GitHub Issues：申请表模板会把结构化请求提交到这个仓库。
3. 免费体检结果：访问者可能把结果复制进邮件或 Issue，主邮件主题通常包含“转化体检结果”“审计申请”或“GrowthAudit”。

每天检查顺序：

1. 打开邮箱，搜索 `GrowthAudit`、`审计`、`audit`、`Founder CRO Kit`。
2. 打开 GitHub Issues，检查新增 `audit-request` / `audit-request-zh`。
3. 记录：来源目标、产品、客户问题、期望时间、下一步动作。

## 二、知道支付是否成功

现在还没有接入支付 Webhook，不能自动确认支付宝/微信收款。确认方式是人工对账：

1. 买家先通过 `kit-checkout.html` 或 `payment.html` 扫码付款。
2. 买家发来支付方式、订单号、支付时间、支付截图和收件邮箱。
3. 在支付宝/微信 App 的交易记录里核对金额、时间和订单号。
4. 记录到本地收入日志：日期、客户、产品、金额、支付方式、订单号、交付状态。
5. 确认后再交付 Founder CRO Kit 或开始审计。

## 三、交付阈值

| 产品 | 金额 | 确认条件 | 下一步 |
|---|---:|---|---|
| Founder CRO Kit | ¥199 / $29 | 支付宝/微信交易记录匹配订单号和金额 | 发送 `assets/founder-cro-kit.html` 或私有交付链接 |
| Quick Audit | ¥1,080 / $149 | 支付记录匹配 | 发送审计申请表 |
| Growth Audit | ¥2,880 / $399 | 支付记录匹配 | 发送审计申请表和页面清单 |
| Implementation Sprint | ¥7,180 / $999 | 支付记录匹配 | 发送项目范围和排期 |

## 四、当前边界

- 不伪造收入、客户和评价。
- 不承诺收入结果。
- 不通过未授权访问收集客户数据。
- 在接入支付 Webhook 或正规支付网关前，必须人工对账后再交付。
