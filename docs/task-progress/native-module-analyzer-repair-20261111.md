# Native module analyzer repair

Batch summary: repair the confirmed communication/application analyzer failures and governance deployment build failure on source c3713c768bb7c7814e03fa245d7347b0aa8ebd1e.

Communication job 130913716628 reports eight strict_raw_type warnings: three collection casts in communication_module_port.dart and five fixture casts in native_module_port_test.dart. These casts now explicitly retain the existing dynamic key/value types. Runtime checks, messages, command receipts and independent readback are unchanged. No analyzer rule or threshold is altered.

Governance deploy job 130913716716 fails on the unused route_registry import in shared_app_bar_compile_test.dart. The test now checks the existing registered screen-health route instead of an unconditional true assertion, retaining compilation of the route registry and its migrated shared app bar.

Validation: exact replacements were counted (three production casts, five fixture casts, one test assertion). Native and governance acceptance must run in GitHub Actions against the published commit. No local Flutter pass or deployment success is claimed.
