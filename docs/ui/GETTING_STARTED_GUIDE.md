# Beginner guide and post-login entry

The shared read-only guide explains dashboard navigation, organization/tenant boundaries, people and roles, services and daily work, communications, billing/reports/audit, and a first-day checklist. Domain descriptions do not declare those operations available; users must use currently authorized menu entries. Learning steps do not invoke business APIs, grant access, or record certified training completion.

The administrator dashboard includes a beginner-guide entry. Training shows one guide step at a time; the existing lessons/self-assessment remain in a separate collapsed area. Web Account includes a clear Open dashboard action. Native success renames the server-capability-gated administration entry to Open dashboard and the training launcher opens the beginner guide. Existing native capabilities and navigation authorization remain unchanged.

Content source: packages/shared/src/getting-started-guide.json. Run node scripts/generate-getting-started-guide.mjs to regenerate native content. Introductory text is currently English; the existing detailed lessons retain EN/FR/ES. No personal information or progress is persisted by the guide.

The two screenshots in websites/typescript/public/assets/guides are browser captures from appearance run 40605650445 using synthetic data and the solid shared palette. They contain no live user or clinical data. Captions explicitly identify examples and warn that roles/menus/totals differ. Tutorial images are public static assets; native guide loads these public examples and provides a text fallback if unavailable.

Website checks capture organization-guide steps at mobile/tablet/desktop sizes, exercise Next and Back entry, and verify image loading without calling mutation APIs. Native widget tests cover guide navigation with administrator access denied. Native source checks do not imply an APK or physical-device release.
