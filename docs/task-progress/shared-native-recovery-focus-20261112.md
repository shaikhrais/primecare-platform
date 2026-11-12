# Native pending-action recovery focus

Batch summary: restore the native work editor's originating Open focus after verified toolbar recovery, using its existing restoreOpen helper inside the existing captured actor/session/scope guard. Preserve draft locking, original request identity and independent readback. No API, authorization, metadata, palette, workflow threshold or registration changes.

Normal native Save already restored focus; the pending-action toolbar path cleared the editor without restoring it. The path now captures the selected item ID before awaiting retry, then calls restoreOpen after the existing guarded successful completion. Views recreated with no selected item keep their prior behavior. The helper itself retains its post-frame scope/epoch, enabled/attached node and visibility protections.

Two native widget regressions are authored: successful acknowledged recovery restores its original opener with one mutation and two readbacks; delayed old-actor recovery cannot steal the new actor Search focus or mutate the new actor data. The existing model, invalid-draft, Close, Save, due-date and recovery assertions are retained. Native execution is GitHub Actions only; authored tests are not claimed passed locally.

Historical proof is extended only for the reviewed one-expression native change. The existing whole-source repair receipt retains original SHA256 a344e5c891e621950570962a1583379f1a4e97e68d524eaf13924b52754a616d and its exact original bytes; only its expected current output and updated digest change. All other seven receipt rows, original dependency pins, sourceHashes, replay schema/limits and authority credits are unchanged. Historical reverse/replay tests remain required, not bypassed.

Pre-repair exactd8c1f506 passed all24listed workflows, including component43190960796,ThemeCenter43190960503,crossbatch43190960366,boundary43190960710,contract43190960736 and workspace43190960487. Thus the disabled-tab fix has actual browser/native acceptance on that head. No full feature or production readiness credit is inferred.

Counts remain strict previous0/current0/new removals0;72source mappings reconciled,0fully accepted/72pending,0/344screens0/147workflows promoted. Fresh work-module and full foundation CI is required for this native change.
