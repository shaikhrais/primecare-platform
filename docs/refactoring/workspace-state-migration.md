# Inline workspace state inheritance

404 existing workspace state classes now inherit BaseWorkspaceState from
primecare_models. Shared storage contains the existing loading, error, title,
log, and data-availability fields. 402 identical copyWith implementations use
the shared generic implementation; the notifications clearError option and
PSW dashboard's custom fields retain their original copyWith methods.

The two existing four-field screen generators now emit BaseLoggedScreenState
inheritance for common storage while retaining their existing copy methods.
BaseWorkspaceState derives from that storage parent and adds hasData.

The verification harness compiles all 404 migrated classes together with their
pinned original implementations. It compares copy behavior, subtype return
values, unchanged log identity, null-as-unchanged semantics, explicit error
clearing, and retained PSW fields. Whole-file comparison checks that code outside the migrated state and exact
shared controller methods remains byte-identical. All 404 inline controllers
inherit BaseWorkspaceController. Existing API calls and custom methods stay
with each child; matching log/loading/error/empty/success methods are shared.
The notifications controller retains its custom explicit error-clearing methods.

This pass changes state structure only. API calls, API
fallbacks, UI layout, and unfinished workflows are unchanged. Other existing
state shapes retain their own implementation. Domain models, screen state,
Flutter controllers, and server routing each have a separate shared parent;
there is no global superclass that mixes these responsibilities.
