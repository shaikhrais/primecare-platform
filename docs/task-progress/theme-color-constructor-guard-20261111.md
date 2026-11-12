# Theme color constructor guard

Batch summary: close a theme-boundary bypass for stored or passed Color constructors. Direct controls and literal colors continue to fail the existing main-branch shared UI workflow.

The guard now rejects Color.new, Color.fromARGB, Color.fromRGBO and Color.from constructor tear-offs in application and shared implementation code outside the existing theme-definition directories. Qualified names and multiline/comment-separated access are covered. Comments, strings and Color.lerp remain unchanged; calls emit one diagnostic.

Validation: all 31 boundary regression tests passed locally. A full scan of the available migration workspace reported zero findings with the updated guard. The exact published commit still requires its GitHub Actions result; the local workspace scan is not a production acceptance receipt.

The tracked skeleton register remains 72 features: 45 source-mapped, 27 needing reconciliation, zero fully accepted and 72 pending full adoption. This enforcement repair does not activate a feature or close a business-workflow, host, device or release gap. Full list: docs/appearance/skeleton-feature-adoption-status-20261111.md.
