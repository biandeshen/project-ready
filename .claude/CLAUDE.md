# project-ready — 项目约定

## 项目性质

Markdown + JSON + Shell 工具/文档项目。零运行时依赖。

## 核心架构

- `playbook.md` — 主执行流程
- `src/roles/` — 角色定义（6）
- `src/rounds/` — 轮次模板（8）
- `src/templates/` — 输出模板（3）
- `src/archetypes/` — 项目类型预配置（JSON）
- `installer/` — 安装脚本

## 文件命名

- 角色：`{NN}-{role}.md`（数字前缀保留）
- 轮次：`{NN}-{round}.md`
- 模板：`{name}.md`（无前缀）

## 不可逆约束

1. **零非必要依赖** — 框架自身不引入运行时依赖
2. **决策记录永留** — READINESS_DECISIONS.md 始终在根目录
3. **增量更新** — 项目变化后重自检，增量更新决策文档

## 测试

```bash
bash tests/validate-structure.sh
```

提交前必须通过。

## Commit 规范

Conventional Commits
