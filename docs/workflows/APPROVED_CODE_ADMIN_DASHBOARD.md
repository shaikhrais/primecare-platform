# Approved Code Admin dashboard integration

The owner approved the HTML dashboard and explicitly requested its application to the interactive dashboard with its sample data persisted in the database (2026-10-28).

The implementation reuses the native tenant, account, reference record, support, document, territory, report and security handlers. Administrative Code Admin grants are registered for operations, the platform bundle and territories; the two administrative reports allow viewing/export only. Clinical permissions, marketing/CEO powers, report email, identity verification and launch approval requirements are unchanged.

The additive seed uses six `demo-primecare-` organizations and 55 non-login accounts at the reserved `primecare.example` domain. It creates pending documents, draft launch records and open support tickets. Original visual examples are stored in a labelled dataset on the actual tenant creation audit event. Call examples are read-only historical illustrations, not provider health or fabricated provider events. No calls, messages, invitations, sessions, clinical records, territory purchases or launch approvals are created. Existing real accounts and security credentials are untouched. A deterministic receipt and transaction lock prevent duplicate seeds; collisions fail closed.

Release is gated by native PostgreSQL tests for text/UUID identities, browser writes/readback, cross-tenant denial, responsive appearance and existing Code Admin security acceptance. The production job preserves existing governance worker bindings, verifies the existing owner, applies only additive native schema, seeds once and publishes from current main. The release artifacts provide deployment and database counts. Passing fixture checks alone does not establish production deployment or live provider availability.

## Production verification — 2026-10-28

The approved release at `b833126a6ab719e66f1ea501c2dbbbb1eae06bf8` completed successfully in [run 40704025855](https://github.com/shaikhrais/primecare-platform/actions/runs/40704025855). Governance deployment readback confirmed preserved bindings and HTTP 200 health. The database transaction reported six tenants, 55 non-login accounts, three documents, two tickets, zero sessions, zero provider actions, zero clinical records and zero launch approvals (`inserted: true`). Nine TypeScript portals were published.

A final responsive table correction at `64fb1df7e68ce7c7043c7487fca36418f1ce688d` additionally verifies that organization values and actions fit their panel, and uses UTF-8 in the native browser fixture. The appearance, native PostgreSQL/browser, and reused Code Admin security checks passed in [run 40704760262](https://github.com/shaikhrais/primecare-platform/actions/runs/40704760262). Its website publication completed successfully in that run; it does not rerun the seed or modify other API workers.

Evidence establishes this dashboard release and its labelled demo records. Live Vapi/SMS availability and the broader legacy workflow backlog remain separate. The unrelated platform-wide contrast and growth panel audit failures are not waived or reported as passing by this release.

## Approved top-bar alignment

The owner's follow-up requested that the live utility bar match the approved demo. The frontend at `ccbeecd048cfba762f66a54242033573a08acbb1` places Administration / current page on the left and compact operation search, organization selector, Canadian English flag and CA avatar on the right. It reuses existing authorized search, language, tenant and account-menu handlers; Ctrl/Cmd+K focuses search. Phone controls retain 44px targets and two rows. Search has a single border and an outer keyboard-focus outline.

[Run 40707167693](https://github.com/shaikhrais/primecare-platform/actions/runs/40707167693) passed native data/browser, 48-state appearance and reused Code Admin security acceptance. Browser checks verify the 70px desktop bar, compact search placement, account avatar, search results, shortcut and Escape behavior in English, French and Spanish at desktop/phone sizes. Website publication completed successfully in that run. This frontend release does not rerun the production seed or change API workers.
