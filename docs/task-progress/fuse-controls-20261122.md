# Fuse control review follow-up

Two defects in existing shared controls are addressed without changing registered
fields, class names, master interfaces or persisted file formats:

- Configurator radio rows keep their 32-pixel minimum but grow and wrap their
  labels for narrow panels and enlarged text. Previously the fixed-height row
  could clip its label. The selection callback is preserved.
- Numeric settings clear stale validation errors when an external value replaces
  the edited value, and revalidate when the permitted range changes. Invalid edits
  still do not call the layout callback.

Regression cases cover normal/enlarged radio geometry and selection, invalid
numeric edits, external replacement and range changes. The reference workflow now
runs these checks, existing settings save/import/owner tests, all foundation tests
and all 18 native capture cases on changes to these controls.

These fixes do not close full Fuse acceptance. Independent horizontal-navbar
Fixed/Static behavior has no field in the strict v1 Dart/TypeScript workspace
contract or the recorded workspace control export. It needs metadata and a
compatible persistence/shell change before a functional control can be exposed;
toolbarStyle and the slide/tabbed appearance setting must not be repurposed.

The prior 42 comparison pairs cover Theme Center and palette fixtures, not all
authenticated business dashboards. The 42 page/widget registrations remain
registered-unimplemented in the latest readback; the dashboard preference kind is
still absent from the active API contract. Original reference assets remain a
private deliverable, with no vendor files added to public runtime source.

This verification workflow performs no production deployment or database write.
