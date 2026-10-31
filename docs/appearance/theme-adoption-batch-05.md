# B05 — page templates and route-specific layouts

Original web and Flutter source factories now share a strict registered page contract. They provide simple/carded content, header/action slots, independent left/right sidebars, permanent/temporary/responsive behavior, normal/page/content scrolling, route scroll resets, page titles and permission-filtered breadcrumbs. Temporary drawers preserve supplied sidebar form state and provide keyboard dismissal and focus return.

Route-specific navigation/toolbar/footer visibility is transient presentation. The web workspace adapter and native workspace flags preserve saved preferences, remove hidden chrome geometry and prevent focus entering hidden chrome. Host-owned navigation/business overlays must be closed before their chrome is hidden. Public/auth/error routes use the same explicit server-authorized binding rules as other routes; no authentication bypass or business destinations are introduced.

The renderer owns presentation only. Invalid/denied web replacements empty the host and revoke old breadcrumb links/callbacks. Native route/actor replacement resets slot identity, scroll state and owned dialogs; stale breadcrumb callbacks cannot activate the new actor's destinations. The host retains responsibility for business handlers, data and external overlays.

Web model/browser/TypeScript checks, four native tests plus analysis on Linux/Windows/macOS, and all 288 page/layout/authority cases per platform in the native-to-web comparison passed at source `7edbc40aa42dd31bad9aaf4eb694ba0499c007be` (workflow run `41242747737`). The existing workspace regression suite also passed on all three platforms with the new chrome flags, including Flutter-web compilation.

Validation is recorded in `theme-adoption-batch-05-evidence.json`. Usage and ownership rules are in `page-template-usage.md`. Live host/control/resource/source registration, authenticated runtime checks, device verification and independent accessibility/localization/release review remain pending. Opt-in source availability does not establish all-app adoption.
