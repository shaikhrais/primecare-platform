# Tenant fixture palette precondition

Batch: give the two tenant acceptance fixtures one shared immutable presentation theme, composed from the existing canonical solid palette and tenant preview sizing tokens. No production theme, authorization, registration or renderer behavior changes.

CI on 6082a3ed failed in browser and PostgreSQL jobs 130824323954/130824323654, and workspace acceptance 130823724504. The fixture's previewTheme contains only dimensions and typography; it has no --color-primary. installPortalPresentation correctly rejects it before assigning window.render, so waiting for a rendered appearance/error control cannot succeed. The previous bootstrap repair did not satisfy this palette precondition.

scripts/fixtures/tenant-presentation-theme.ts reuses existing definitions rather than creating fixed fixture colors. Both layout and work-module host fixtures import it. A new test runs the real presentation bridge and Screen Manager against this exact theme and the existing tenant route. Existing missing/invalid theme and responsive-CSS rejection tests remain enforced.

Local validation: 152 Screen Manager/platform presentation checks pass, JavaScript syntax passes, and whitespace is clean. Full browser/PostgreSQL and native acceptance require fresh GitHub Actions execution; the local browser socket restriction is not bypassed. Feature acceptance remains 0/72 complete and 72 pending. No ready-screen or workflow credit is created.
