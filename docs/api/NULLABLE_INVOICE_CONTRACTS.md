# Nullable invoice contracts — batches 164–165

PostgreSQL invoice status, currency, subtotal, tax and total are nullable. The list, detail, summary and premium compatibility contracts now describe these fields as string or null, matching the existing runtime behavior. IDs and non-null creation/update timestamps remain required.

Batch 164 corrects list/detail schemas and the canonical stored governance schemas. Batch 165 corrects currency/status group and decimal aggregate schemas. The compatibility invoice schema is regenerated from its canonical contract. No additional operation declarations, grants or data mutation are introduced.

Present amounts are exact PostgreSQL decimal strings. Null means the value is absent; it is not zero and does not imply CAD or another currency. A group containing only null amounts has null sums. Consumers must preserve this distinction and display an unknown value rather than inventing a default. Invoice status remains a stored label, not proof of settlement.

Gateway fixtures check null preservation for lists, details and status groups. Disposable PostgreSQL tests set one owned fixture invoice's nullable fields to null and verify canonical detail, compatibility list and grouped sums while retaining actor/profile/tenant scope. Both UUID and text CI suites remain required; this is not production verification.
