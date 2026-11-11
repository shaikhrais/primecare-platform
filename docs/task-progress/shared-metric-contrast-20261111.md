# Shared metric contrast fix

Two shared library components: PrimeCareStatCard and GovMetricCard. Replace transparent accent backgrounds with a tint composited on the actual theme surface, and resolve icon foregrounds against that exact tint. Resolve stat-card delta labels and governance progress percentages against the actual card surface. Preserve dimensions, animation, callbacks, colors supplied by callers and progress values.

This is a shared component correction, counted separately from boundary replacements (zero lexical violations removed). Exact revision receipts compose with earlier button migration history. Native regression covers both actual shared components across all presets, 1x/2x text scales and caller-supplied mid-gray accent. Native execution remains pending CI.

Validation: 255 migration tests pass with earlier button receipts still intact; the metric utility is idempotent. YAML and native delimiter checks pass. Two actual shared-widget regression cases are added to the existing Theme Center workflow.
