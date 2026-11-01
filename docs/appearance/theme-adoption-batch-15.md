# Batch 15: account identity/settings and gated application templates

Original optional templates now cover academy, commerce, AI images, profile, settings and help centre. Two source flows are connected and tested: existing read-only session identity, and navigation-shortcut settings through API 777 and the inherited B07 sync client. The other four templates intentionally show unavailable until real registered workflow/provider dependencies are supplied.

Production metadata run [41276699858](https://github.com/shaikhrais/primecare-platform/actions/runs/41276699858), attempt 2, committed and independently read back 20 optional controls, 20 optional required-element records and 96 EN/FR/ES draft translations across 32 resources. The first attempt failed safely on a lock timeout before writes. No APIs, grants, business records, schema or runtime activation were added.

The registration discovered existing API 16402 for self-session identity and confirmed API 777 for account preferences. It also recorded missing queried learning, commerce and help candidates. Profile API 16402 retains its legacy null service-name metadata; routing/host review remains required. Source presence alone is not treated as API registration. No image-provider or payment operation is enabled.

The adapter maps authorized localized shortcut titles to registered screen IDs, then reuses B07 draft persistence, validation, scope, CAS and UUID receipts. Saved success requires acknowledgement and a fresh independent item read; an acknowledged save whose verification read failed is confirmed without issuing another write. Tests separately query PostgreSQL and reload the UI. Captured role/token changes and unregistered values fail closed. Profile identity is read-only. Existing password, MFA, contact, session and administrative flows are preserved.

Source `1d9ebbf355f13faaf8d4a7b7e1ae034a56e80d42`, verification run [41277937362](https://github.com/shaikhrais/primecare-platform/actions/runs/41277937362), CI jobs and proof excerpts are recorded in `theme-adoption-batch-15-evidence.json`. Read `application-modules-usage.md` for imports, authority, cache/recovery limits, platform support and exact remaining features. Native live collection adapters, host activation, full conflict recovery UX and human accessibility/localization/release review remain pending. No whole-screen readiness or full reference adoption is claimed.

B16 is next: dashboard families and supporting pages, using existing governed data sources. B15's blocked dependencies remain tracked.
