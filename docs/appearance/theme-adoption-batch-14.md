# Batch 14: shared communication module foundations

Original optional mailbox, messenger, notification and attachment-reference templates now reuse the shared collection/editor engine. Mail and messaging use the inherited communication services and existing registered HTTP contracts. The new mailbox view is read-only; the messenger supports text send/read receipt with independently verified results and duplicate-safe original-key confirmation. Notifications remain unavailable pending API registration. File support is an authorized read-only attachment inventory, not general document/folder CRUD.

Production metadata run [41269023480](https://github.com/shaikhrais/primecare-platform/actions/runs/41269023480) committed and independently read back 18 optional controls, 18 optional required-element records and 111 EN/FR/ES draft translations across 37 resources. Five existing API bindings were verified; no grants, APIs, business records, schema changes or runtime activation were added. Notification discovery failed closed before writes and its missing binding remains explicit.

Source `e75c8af8806e680b0b9039890253a9b38b9fa86f` and verification run [41269984530](https://github.com/shaikhrais/primecare-platform/actions/runs/41269984530) are recorded in `theme-adoption-batch-14-evidence.json`. Tests use the real existing HTTP handler and inherited services over isolated PostgreSQL storage, with independent SQL and reload checks. No external message or email is sent. Flutter tests exercise shared native factories, not a deployed native transport.

Read `communication-modules-usage.md` for imports, authority, exact adopted features, bounded search/pagination, lifecycle, retry and remaining requirements. Host mounts, native binding, deployment/device acceptance and human localization/accessibility/release review remain open. No whole-screen activation or full reference adoption is claimed.

B15 is next: academy, commerce, AI images, profile, settings and help centre, subject to existing governed workflows. B14's unbound and unmapped features remain tracked when moving on.
