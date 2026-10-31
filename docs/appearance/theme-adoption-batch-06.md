# B06 — shared advanced Theme Center

Original version-2 theme factories provide independent main/navigation/toolbar/footer palettes, explicit light/dark modes, readable text and semantic foregrounds, derived light/dark shades, typography/spacing/radius/border/density tokens and safe workspace projection. The optional web and Flutter editors consume allowlisted registered field schemas with conditional visibility, instead of duplicating forms per layout.

The source editors include isolated palette preview, formatted configuration viewing, copy, JSON import/export, reset and scoped named-theme CRUD. Writes are validated before mutation; failed storage does not commit in-memory state. Native asynchronous actions and both editor lifecycles reject stale actor work. Existing business content is not replaced by previews.

Version-1 personal-theme JSON remains in its original validated contract. Existing web XML import is reused; native supports canonical version-1 layout exports. Legacy results are delivered to explicit host callbacks, with no automatic lossy migration or storage-key replacement. See `advanced-theme-usage.md` for compatibility boundaries and integration ownership.

Verification is recorded in `theme-adoption-batch-06-evidence.json`. Source factories are opt-in; new production controls/resources/source bindings, authenticated host/runtime checks, connected device verification and independent accessibility/translation/release review remain pending. Contrast tests cover compiled palette foreground pairs, not whole-app compliance. No all-app activation or human approval is claimed.
