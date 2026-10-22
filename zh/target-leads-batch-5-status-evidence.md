# 第五批线索：状态更新与证据交接

更新日期：2026-10-23  
服务：AI Workflow Fix / 客户状态更新工作流诊断  
目标价：¥680（海外页面 $99）  
原则：只列公开证据；发送前需用户批准；不伪造案例；不使用未授权访问。

## 合格标准

- 产品或服务涉及项目状态、客户沟通、工单、审批或证据交接。
- 公开页面能看出明确的客户沟通或 AI 工作流场景。
- 有公开、可验证的联系渠道。
- 不把“能不能自己实现”当作淘汰理由；重点是能否帮他们减少交接摩擦。

## 目标清单

| 优先级 | 目标 | 联系渠道 | 公开证据 | 切入角度 |
|---|---|---|---|---|
| 1 | Alignear | `sales@alignear.com` | <https://alignear.com/> 明确写着“Turn Linear Work into Client Updates”，包含 cycle reports、client portal、client blockers、decision inbox。 | 他们已经把 Linear 工作转成客户报告；下一步是让每条客户可见结论绑定工单、会议纪要或审批记录，并减少发送前泄露内部细节的风险。 |
| 2 | ClientDock | `support@clientdock.me` | <https://clientdock.me/> 面向 freelancer 和 agency，提供 file sharing、notes & updates、feedback/approvals、secure access。 | 客户门户能承载更新，但团队仍要先从工单、聊天和文档提炼安全版本。可以补一个“证据到客户更新”的检查层。 |
| 3 | Auxx | `sales@auxx.ai` | <https://auxx.ai/> 展示 Kopilot 读取 ticket、draft reply、update record，并支持 procedures、allow-list 和 access controls。 | 他们的 agent 已处理支持回复；可把同一思路扩展到跨客户项目状态：提取证据、生成草稿、标注审批点和禁止发送的信息。 |

## 暂不触达

| 目标 | 原因 |
|---|---|
| MakeWay | 痛点相关，但未找到公开邮箱；批量表单提交容易变成 spam。 |
| Atrium | 痛点相关，且近期仍在更新，但公开渠道只有仓库，没有明确商务邮箱。 |
| Relnotes | 主题相关，但首页未显示明确联系邮箱，暂不猜邮箱。 |

## 发送节奏

1. 用户批准后，先发送 Alignear。
2. 48 小时无回复，不自动跟进；先看是否有打开、退信或拒绝信号。
3. 若第一条没有明显退信，且用户同意继续，再发送 ClientDock。
4. Auxx 放最后，避免同一天内向多个通用 sales 邮箱群发。
