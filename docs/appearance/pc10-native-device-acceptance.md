# PC-10 native device and human acceptance

Status: pending actual device execution and human review. Automated native widget tests use a test storage platform; they do not certify OS storage, signed-device launch or a screen reader.

## Required build identity

Record app name, commit SHA, producer run/job, artifact ID and SHA-256, device model/OS, installed version, reviewer and date. Use a completed artifact containing the native host source, not an older successful Apple artifact. iOS device installation requires the authorized signing team and provisioning profile; an unsigned archive cannot satisfy this step. Never put credentials or bearer tokens in evidence.

## Device journeys

Use an authorized tenant-admin test account and its own tenant. Do not change existing user permissions to make a test pass.

| Journey | Required evidence | Status |
| --- | --- | --- |
| Credential login and entry | Registered /tenant-dashboard opens for the correct tenant; profile matches the authenticated self; other roles and expired sessions cannot reveal content | Pending |
| Shortcut persistence | Select an allowed destination, Save, inspect confirmation, force-stop/relaunch, verify the same saved selection without a duplicate mutation | Pending |
| Dirty draft and account navigation | Change without saving, open the existing sensitive account flow, return and confirm preserved draft; ordinary refresh must not discard it | Pending |
| Scope retirement | Sign out/change accounts while data loads; previous profile, counts, activity, search results and shortcuts disappear; new account reads its own data | Pending |
| Network and conflict recovery | Exercise offline read/save, lost acknowledgement and revision conflict on owned fixtures; recover using original receipt or explicit conflict choices without silent overwrite | Pending |
| Project and analytics | Read actual authorized counts; missing values remain unavailable rather than invented zeros | Pending |
| Activity and search | Show bounded authorized records, empty search and refresh; no business mutations; no other-tenant results | Pending |
| OS storage and privacy | Verify restart persistence and account separation on actual OS storage; verify backup/privacy policy using disposable fixtures | Pending |

## Human accessibility and localization review

For EN, FR and ES, record viewport/text scaling, orientation and the reviewer decision. Use TalkBack on Android and VoiceOver on Apple devices, plus keyboard/focus navigation where supported. Confirm meaningful labels and announcements, logical focus order, operable Save/retry/conflict controls, understandable loading/denial/empty states, readable translated text and no clipped controls. Review long lists and an empty search separately. Automated semantics and axe checks do not replace this decision.

Record pass/fail per journey, reproduction steps and evidence links. A failure stays open until the repaired exact-source artifact is retested. Human approval must be an actual reviewer decision; no script may create it from green CI.

## Completion boundary

These journeys cover the registered self-profile, shortcut settings and authorized read views. They do not approve academy, commerce, generic AI chat, help content authoring, invoice payment or tenant finance. Those require their own registered business contracts, authority and provider evidence before implementation/acceptance.
