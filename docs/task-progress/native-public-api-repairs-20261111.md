# Native public API follow-up

Confirmed CI at ba846b798cf9ecfed8d17a32c0cf9dd4780bae5c:
corporate, client and business-development importer suites passed.
Enterprise/clinic/governance actual libraries exposed missing shared scaffold export.
Governance also exposed missing shared text-field export and a broad UI import
that reintroduced the UI ScreenRegistry beside the application's registry.

Public UI entry point now exports both shared adapters. Governance keeps its local
registry identity with an explicit hide; exact source migration receipts retain
and reverse these import-only amendments. The public API widget test renders both
adapters through the same package entry point used by consumers.

The shell lifecycle browser assertion now verifies nonpersisted default layout
attributes after unbinding, rather than expecting those attributes absent. This
matches the explicit default-only presentation manager contract; the assertion
still requires personal active styling and appearance controls to disappear and
late account import callbacks to be ignored. No shell production behavior changed.

Native/browser acceptance must be read from the new commit's CI.
Source migration completion does not imply runtime activation or production readiness.
