# Shared business base classes

`base.ts` is the shared domain layer for sales, operations and restricted HR adapters. These classes create no routes, controls, grants, notifications or database records. New live integrations still require production governance registration. Policy: [business flags](../../../../docs/business/business-flags.md).

| Class | Responsibility | Consumer |
| --- | --- | --- |
| BusinessMetricsBase | Existing campaign arithmetic | GrowthAnalytics inherits it; existing worker campaign consumers keep the same API |
| BusinessFlagRule<T> | Common evaluation contract and severity/coverage summary | SalesTargetRule and IncidentFlagRule |
| SalesTargetRule | Approved final target and explicit interim milestone evaluation | Ready for a registered, evidence-backed sales adapter |
| IncidentFlagRule | Preserve verified critical issues while showing evidence gaps | Ready for registered operations and restricted HR adapters |

## Use

```ts
import {BusinessFlagRule, SalesTargetRule, IncidentFlagRule} from './base';

const sales = new SalesTargetRule().evaluate(salesEvidence);
const operations = new IncidentFlagRule().evaluate(operationsEvidence);
const summary = BusinessFlagRule.summarize([sales, operations]);
// Render status plus unknown coverage. Never render only a color.
```

Inputs must come from an authorized adapter that checks tenant scope, currency/metric compatibility, target version, reporting cutoff, source completeness, approved freshness limits, unique closes and reversal accounting. Use integer counts or integer minor currency units. These pure classes cannot authenticate callers or verify evidence references; do not pass untrusted request booleans directly. An HR adapter supplies only authorized booleans, never case details. Do not expose unapproved draft flags through a live endpoint.

Use `BusinessFlagRule<T>` when another registered area needs its own evaluation. Keep rules out of UI. Inject already-approved deadlines/milestones through adapters; do not add arbitrary thresholds to subclasses. Persist source evidence and rule version in the registered service, not in these stateless objects. Summary is a severity and coverage calculation, not an authorization boundary.

GrowthAnalytics' existing funnel remains a planning estimate using elapsed time. It is not verified sales attainment and must not supply the evidence for SalesTargetRule. Inherited campaign calculations intentionally preserve prior behavior.

Run `node --test packages/shared/test/business-base.test.mjs` on Node 24 with native TypeScript stripping. No production connection or synthetic governance registry is needed. Tests cover invalid amounts, incomplete/unapproved/stale evidence, target misses, explicit milestones, critical incidents, mixed coverage and inherited campaign behavior. Live sales/HR/operations acceptance remains pending registration, adapters and current-client tests.
