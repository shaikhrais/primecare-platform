# HSW API reuse: assigned care before a new endpoint

This is an implementation handoff, not a production release or a declaration that all HSW operations exist.

The registered shared Care API already has `GET /v1/governance/care` for a signed-in, scoped worklist. The care registry treats `hsw` as support; its service verifies the active identity, role and assignment before access. Existing Care action routes are distinct from the old HSW `checkin`, `checkout`, and alert declarations. Do not alias a clinical start or completion to a time-clock tap, and do not infer notification authority from a case permission.

| Dashboard need | Recommended implementation | Held boundary |
| --- | --- | --- |
| View assigned visits | Reuse the existing authenticated Care worklist and its current response schema. Do not send tenant/provider overrides or expose notes by default. | Confirm the HSW dashboard's own portal integration and signed-in usability before activating the shell. |
| Start authorized care | Use the existing approved Care action as designed, with the current clearance, plan, assignment, consent and transition checks. | The legacy HSW check-in path is not implemented or interchangeable. |
| Submit visit outcome | Use existing Care visit submission with current plan/task outcome validation and independent review. | The legacy HSW checkout path is not implemented or interchangeable with completing a visit. |
| Alerts | Use only separately approved Care issue or escalation workflows. | No evidence that the legacy HSW alert operation may open a new dispatch path. |

Evidence: `docs/care/openapi.json`, `docs/care/README.md`, `packages/shared/src/care/registry.json`, and the named text-ID and UUID-ID HSW cases in `scripts/test-care-delivery.mjs` both passed locally with disposable fixtures. The combined local regression was not green: 100 passed, 20 skipped, and its browser setup failed because the local theme fixture lacked `theme_design_tokens`. Not production or signed-in live evidence.
