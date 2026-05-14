# Project Readiness Decision Document

> **审阅日期:** 2026-05-14
> **项目:** project-ready
> **流程:** 自检犬粮运行 — 6 轮次 + 清零者元审查

---

## 一、批准项

| # | 决策 | 来源 | 理由 |
|:-:|:-----|:-----|:-----|
| 1 | 新增 `tooling-project` archetype | R1 | 框架应能检测自身类型 |
| 2 | 建立 `validate-structure.sh` 结构校验器 | R1+R2 | 文件完整性 + 引用一致性 |
| 3 | 文件命名规范文档化 | R1 | 新贡献者有明确指引 |
| 4 | archetype JSON Schema | R2 | IDE 自动补全 + CI 检查 |
| 5 | `.editorconfig` 配置 | R3 | 零依赖的跨编辑器一致性 |
| 6 | `.vscode/extensions.json` | R3 | 自动推荐必要扩展 |
| 7 | GitHub Issue 模板 | R4 | Issue 质量提升 |
| 8 | GitHub PR 模板 | R4 | PR 信息完整 |
| 9 | GitHub Actions CI workflow | R5 | PR 自动检查 |
| 10 | Status badge → README | R5 | 项目可见状态 |
| 11 | `.claude/CLAUDE.md` 创建 | R7 | Claude Code 项目约定 |
| 12 | README 增加 TOC | R7 | 降低进入门槛 |

## 二、否决项

| # | 否决内容 | 来源 | 理由 | 替代方案 |
|:-:|:---------|:-----|:-----|:---------|
| 1 | Prettier 引入 | R3 | 零依赖项目没必要引入 Node.js | `.editorconfig` 覆盖 80% |
| 2 | bats 测试框架 | R2 | 单贡献者时期维护成本 > 收益 | 纯 Shell 断言 |

## 三、分歧裁决

### 裁决 1：工具链密度

R3 主张全套工具链 → 清零者质疑过度 → 采纳清零者。.editorconfig 立即做，Prettier 升为 P2。

### 裁决 2：版本号策略

R4 提出未定义 → 清零者指出无人讨论 → git tag 管理。不写正式文档，有实质变化时手动打 tag。

### 裁决 3：端到端验证 vs CI

R5 主张 CI = 质量 → 清零者质疑真正风险在 playbook 逻辑 → 两者不同层面。E2E 验证逻辑正确性，CI 保证结构完整性。都做。

## 四、实施优先级

| 优先级 | 事项 | 来源 | 目标 |
|:------:|:-----|:-----|:-----|
| P0 | 在 3-5 个项目上端到端验证 | 清零者 | 立即 |
| P1 | validate-structure.sh + CI + CLAUDE.md + .editorconfig + tooling archetype | 多轮 | PR #2 |
| P2 | JSON Schema + Issue/PR 模板 + Status badge | R2+R4+R5 | PR #3 |
| P3 | Prettier + bats | R2+R3 | 贡献者 >2 人时 |

## 五、新约束

1. **零非必要依赖** — 框架自身保持零运行时依赖，Node.js 只在 CI 中允许
2. **决策记录永留** — READINESS_DECISIONS.md 始终在项目根目录
3. **增量更新** — 框架变化时重新自检，增量更新此文档，不覆盖
