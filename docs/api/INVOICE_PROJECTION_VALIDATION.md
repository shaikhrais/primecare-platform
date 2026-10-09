# Invoice projection validation — batches 189–190

This repairs the existing owner-bound invoice list/detail (189) and currency/status grouped summary (190), including the existing invoice compatibility GET. It adds no operations, grants or mutations. Nullable stored amounts/status/currency remain null; finite decimal values remain exact strings.

List and detail share one projection validator. IDs must be strings; status/currency must be strings or null; created_at/updated_at must be valid timestamps. Each amount must be null or a signed decimal string matching the exact OpenAPI pattern. JavaScript numbers, missing values, NaN/infinity text and malformed decimal values are rejected with a sanitized no-store 503. There is no conversion to floating point, default currency or inferred zero balance.

Summary validates the stored currency/status labels, exact decimal sums and nonnegative integer invoiceCount. List and summary totals require nonnegative safe integer values from PostgreSQL COUNT(*)::int. Missing, string-coerced, fractional or non-finite counts fail closed. Existing client owner/tenant filters, strict request parsing, repeatable-read read-only snapshots, rollback and source limits remain unchanged.

Schemas are generated in the existing `client-self-batch-7.openapi.json`, `client-invoices-batch-12.openapi.json` and current `governed-read-aliases.openapi.json`. They retain string/null amount types and now specify decimal syntax and nonnegative count minima. Historical versioned compatibility snapshots remain historical evidence; consumers should use the current exact spec.

Unit fixtures exercise amounts beyond JavaScript safe integer precision, negative exact sums, nulls, malformed identities/labels/timestamps, numeric and non-finite values, bad group and pagination counts, rollback and schema alignment. Disposable loopback auth_test PostgreSQL fixtures preserve NUMERIC(20,4) values such as 9007199254740993.1234 and reject actual PostgreSQL numeric NaN in list/detail/summary. UUID/text CI remains a separate gate from local fixture evidence. No production or settlement claims are made.
