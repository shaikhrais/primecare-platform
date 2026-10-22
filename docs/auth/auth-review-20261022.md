# Auth engineering review and owned-inbox verification

Review target: deployed runtime `116d1eb30108f4590493a3cf1a209d7d5312ac63`, saved main checkpoint `f7c4f423598e03b7d7f369b9ab56072cc1ee3ab0`.

The implementing assistant reviewed recovery-code generation and hashing, lifecycle proof/session checks, temporary elevation/support authorization, notification leasing and native email transport. Recovery codes have 128 random bits and context-bound hashes. Management requires current owned sessions and fresh password/factor proof. Support uses fixed aggregate-only scope, current tenant approval and bounded session-linked authority. Existing native PostgreSQL and deployed EN/FR/ES receipts remain the behavioral evidence; this review does not confer independent approval.

## Email verification gap and new check

The existing receiving Worker already accepts `auth-test@15minutes-email.com`; additional addresses are unnecessary. Existing password recovery tests correlate received codes with their database hashes. The lifecycle test previously used non-deliverable synthetic addresses and claimed only durable queuing or transport acknowledgement.

The optional `VERIFY_MFA_NOTICE_INBOX=1` journey uses the existing owned inbox, refuses any existing account using that address, and exercises the real browser lifecycle in English, French and Spanish. It waits up to seven minutes per locale for five queued notices to reach `sent` and five new MIME messages matching the exact sole sender, QA recipient, localized subject and plain-text body. The workflow shares the existing owned-inbox concurrency group. Only complete batches with unchanged hashes are cleaned; prior messages and incomplete/ambiguous batches are preserved. Synthetic account cleanup retains identity and tenant guards. No password, seed, code, token or raw MIME is written to evidence.

Evidence limitation: the native email adapter does not persist provider message IDs against outbox IDs. The new receipt explicitly identifies batch-level observation and leaves `perEventMessageIdVerified=false`. It cannot prove a one-to-one event/message mapping or an external mailbox provider's delivery. Live results are pending the `Verify auth lifecycle security notice inbox` run; local parser/cleanup tests are not live delivery proof.

## Validation

Five new MIME/cleanup tests, three existing owned-inbox tests, and 23 lifecycle receipt, secret storage and keyring-tail tests passed locally. Both changed Python modules compiled. Production runtime and registered API/UI definitions are unchanged.

Independent reviews, physical-device acceptance and reviewed v1 retirement remain separate gates. No review status or production-readiness credit is changed by this document or optional inbox receipt.

## Current review run and preserved failures

Source `34f68661` passed native PostgreSQL foundation, Flutter regressions, workflow contracts, deployed key-binding/migration proof and the three-locale native MFA baseline. The extended browser producer failed before notification observation: first during initial logout, then after completing English replacement/recovery and reloading the recovered account. Synthetic identity/tenant cleanup passed. The parallel ordinary lifecycle producer also failed during the initial logout interaction. These failed receipts receive no acceptance credit.

Targeted browser diagnostics now retain only fixed error categories, exact stages and a masked screenshot on the account success page when no setup-key or saved-code semantics exist. Password/editable fields are masked. No screenshot is taken of MFA proof screens. Public deployed sign-in and password-recovery screenshots were captured for user feedback.

The email-delivery workflow now isolates the deployed API → PostgreSQL → scheduled sender → owned receiving Worker journey from the unresolved browser interaction. It creates the same guarded disposable QA identity, invokes the registered enrollment/recovery/replacement endpoints in each locale, then observes and cleans the five-notice batch. This supplies no browser acceptance credit and does not resolve the separately tracked browser failure. API/database/queue and actual inbox outcomes must still pass; no direct test-mail shortcut is used.
