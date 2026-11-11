# Shared Material control closure batch

61 direct constructors in 26 consumer libraries. Add 19 real shared Material subclasses, generated from the public generative constructor signatures in the pinned Flutter3.41.5 sources. Inferred super parameters retain SDK types, required parameters, defaults, assertions, state creation and Material theme behavior. Named generative variants are forwarded to their matching SDK constructors; FilledButton retains its styleFrom function and nullable-icon behavior. This introduces no copied rendering implementation or replacement theme literals.

Replace constructor identifiers and add narrow shared-library imports. Keep values, validators, keys, callbacks, form state, selected items, dialog actions and dimensions intact. Native compile inventory covers all26 consumers. SDK comparison tests cover all19 adapters in light/dark themes, callback/input/validation/menu behavior and named filled-button variants. Existing consumer tests now find the actual shared subclasses instead of accidentally missing them through exact base-type lookup.

The strict boundary now also rejects direct Material inheritance/implementation outside the exact shared implementation file. Other controls and all color literals still fail there. No baseline exemptions. Output-hash-gated history reverses this constructor-only stage before previous palette/control stages; unknown revisions still fail their original source-hash checks.

Publish support and consumer groups directly to current main, no branch or force update. Zero source diagnostics will mean the strict migration inventory is cleared; native execution, runtime registration and full product acceptance remain separate and pending until their checks complete.

Validation: all280 migration tests and28 strict-boundary tests pass. SDK generator --check passes. All26 consumer receipts reverse to exact input hashes, reapply exactly, and are idempotent. Source scan is zero diagnostics under the strengthened inheritance guard. Native test syntax and workflow YAML pass; actual Flutter execution is still pending GitHub runners.
