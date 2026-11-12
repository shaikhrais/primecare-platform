# Page workspace chrome ownership after disposal

The shared `PageWorkspaceChrome` restored its original navigation/toolbar/footer state on disposal, but remained callable. A later `apply` could overwrite a replacement controller's current hidden/inert policy; repeated disposal could remove the replacement's ownership marker and allow a third controller to mount. A retained `PageTemplateView` also called its retired chrome during update or teardown.

Make disposal idempotent and mark the controller retired before restoring its original state. Later `apply` and `dispose` calls are inert. The live replacement keeps its ownership marker and visibility policy; originally hidden or inert slots retain their original values. Existing route metadata, saved workspace profiles, slots, labels and authorization are unchanged.

Three lifecycle regressions fail against the old source and pass with the repair: apply after disposal, repeated disposal beneath a replacement, and retained actual page-view update/disposal through retired chrome. All seven page lifecycle tests, two page authority/model groups and TypeScript compilation pass. The model also regenerates the existing 288 route/layout parity cases; those are fixtures, not feature acceptance credits. The real page/workspace browser fixture now retires the original controller, mounts a replacement and verifies old calls cannot change its marker, hidden/inert slots or policy attributes. Fresh GitHub browser/native/parity verification remains required; no local browser/native pass is claimed.

Counts remain 72 source mappings, 0 unreconciled, 0 fully accepted/72 pending. This closes a source ownership defect, not complete page-host rollout, actual-device or required review gates. No task-tracking infrastructure is added.
