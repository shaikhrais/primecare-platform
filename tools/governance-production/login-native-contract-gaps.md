# Native Login: contract gaps and finite localization read design

Source snapshot: PR #222 commit 06fa7ab8a151052ceea22475176b363c32dbc805. This is a source inventory,
not a production contract, executed query, translation approval, or access grant.
No new production reader is enabled. Existing synthetic bootstrap remains separate.

## Direct path to screen 1

1. Owner confirms whether native `LoginView` is governed by the exact `login`
   screen record, its current version, app ownership and lifecycle. Do not use
   `auth_login_web`, `auth.login`, or the presentation role label `Public`
   as interchangeable database identities.
2. Obtain only that screen's approved requirements, required elements,
   section/component bindings, action/API bindings, theme owner and finite
   localization bindings. Missing rows are gaps, not permission to invent rows.
3. Reconcile current password-exchange, tenant-selection and MFA policy versions
   with the implementation owner. Then implement the approved delta and test the
   screen in GitHub Actions. A passing metadata fixture is not this acceptance.

## Credential form and shared chrome: 20 finite auth keys

The Login branch plus its rendered shared shell and password-visibility control
uses exactly this source-derived candidate set in the inspected snapshot:

- `login_title`
- `login_body`
- `email`
- `email_hint`
- `password`
- `forgot`
- `loading`
- `login`
- `signup`
- `language`
- `help`
- `help_body`
- `footer`
- `brand`
- `eyebrow`
- `brand_title`
- `brand_body`
- `brand_note`
- `hide_password`
- `show_password`

Dynamic `${page.name}_title/body` resolves to login_title/login_body.
Desktop branding is included, not just mobile. The Login shell has signup and
language navigation but does not render the back button. Following navigation
to Signup, Language, Forgot Password or Success is a separate screen scope.

`authScreenText` reads live screen `auth` with generated bundled fallback.
`register-live-screen-text.py` maps resource keys to `screenText.auth.<key>`.
The same script historically copies `auth_design_<key>`; those are provenance,
not an automatic second live authority. No prefix or all-auth export is needed.
The checked-in auth JSON contains these keys in EN/FR/ES; this observation does
not certify live values, reviewed/approved flags, version or translation quality.

## Other Login-reachable text is not in that 20-key set

- Credential errors use `context.tr('auth.enter_credentials_to_continue')`
  and `context.tr('auth.authentication_failed')`. Their runtime namespace and
  governance binding must be supplied separately; do not prepend screenText.auth.
- A null errorReason uses state.errorMessage verbatim. There is no finite key
  derivable for arbitrary controller/server messages. This needs an explicit
  reviewed public-error contract, not a database dump of error text.
- When MFA is pending, Login renders NativeMfaForm instead of credential fields.
  Its nativeMfaText keys are title, setup, code, submit, cancel, error, loading.
  These come from mfa_catalog.g.dart, generated from shared auth-mfa.json.
- Reachable MFA lifecycle labels are recoveryCode, working, recover, cancel,
  newCode, confirm, recovery, error, and newKey (MfaReplacementKey).
  They come from authLifecycleText via mfaLifecycleLabels, not authScreenText.
  Enrollment/replacement/recovery reachability depends on controller policy;
  source UI branches alone do not authorize those capabilities.
- The shared JSON sources identify screenId 949. That is a source reference
  for the MFA surface, not proof it is Login's native screen ID or an approved
  live foreign key. Never join it to Login by coincidental numeric identity.
- Setup keys, OTPs, passwords, recovery codes and challenge/session payloads
  are runtime secrets, not governance metadata. Exclude them from all reads,
  reports, snapshots and CI artifacts.

## Fixed logical production query design (not executable SQL)

Retain the bootstrap's six-relation manifest-validated metadata scope and exact
four method/path pairs. The fixture cannot be pointed at production.
A later separately reviewed production implementation must:
- First authenticate the exact manifest and verify expected project/database,
  schema, physical relation types/ownership/RLS and SELECT-only privileges.
- Resolve native login independently from web metadata. Require exactly one
  approved identity/version before following presentation relations.
- Read screen_requirements: id, screen_id, business_purpose, user_story,
  acceptance_criteria, restricted to that approved native screen ID.
- Read screen_required_elements: id, screen_id, element_key, element_type,
  label, test_id, required, restricted to that same screen ID.
- Stop on absent/ambiguous native section/component/theme bindings. Do not
  infer physical names, columns or joins from web layout registration.
- For the 20 candidates, select language_resources resource_id/resource_key
  by an exact parameterized IN list of screenText.auth.<key>; select languages
  language_id/language_code for exactly en, fr, es; then language_resource_values
  resource_id/language_id/translated_text/reviewed/approved/version only for
  those selected IDs. Validate each projected field against the pinned manifest.
  Require exactly one resource per key, language per code, and value per pair.
  Missing, duplicate, unapproved or incompatible versions block acceptance.
- Bound stages to 20 resources, 3 languages and 60 values, each with an extra
  sentinel row to detect overflow; enforce field/total byte limits and an
  external hard memory/time limit. Parameterize values, quote only authenticated
  identifiers, require read-only transaction/TLS, and rollback on every exit.
- Do not query auth_design_* or screenText.auth.* by wildcard. Other error/MFA
  namespaces need separately confirmed exact mappings before any extension.
- Keep contract text/private results in an approved private destination. Public
  output is fixed statuses/counts only. This repository is public.

The requirements/element projections above are source candidates from the prior
Login design, not a claim those physical columns exist in production. No
executable SQL is supplied where manifest types or native joins remain unknown.

## Exact missing inputs and access

The shortest route can be a governance-owner-provided, sanitized and versioned
Login contract packet with the bindings above; direct database access is not
required if that packet establishes authority. Do not include account data or
credentials. Supply it through an approved private review destination.

For a direct read instead, the owner must identify the intended provider project,
database and schema, an existing least-privilege SELECT identity, approved native
screen/version, exact bounded query scope and private result destination.
Approve the final immutable production reader/runtime and protected execution
before use. Do not create credentials, configure persistent secret access,
weaken controls, or treat broad pre-approval as approval of unknown scope.
Neither source inspection nor synthetic tests prove live authority.

## Verification boundary

No new offline test was added merely to assert these prose claims. The existing
64 isolated tests already cover bootstrap SQL scope, privacy, TLS, limits and
SELECT-only behavior; no tests ran on a laptop or in this cloud workspace.
Their passing GitHub run is:
https://github.com/shaikhrais/primecare-platform/actions/runs/42547891494
It tested source head 06fa7ab8a151052ceea22475176b363c32dbc805 through PR merge
8d6ff4b13a833eee78aa94f342037c3bba2b59b5, not a credentialed production read or
new UI acceptance. This document alone does not change any runtime behavior.

## Inspected source pins

- `packages/primecare_ui/lib/src/features/auth/login_view.dart`: `87ebbc56237c2a195996e702793ea644bb2b9d32`
- `packages/primecare_ui/lib/src/features/auth/auth_experience.dart`: `242b875f7e9b83043355678b0a13e10755973c4b`
- `packages/primecare_ui/lib/src/localization/auth_screen_text.dart`: `5d911aef5f964fdeef9000af768c8f8fbd98f20a`
- `packages/primecare_ui/lib/src/localization/screens/auth.json`: `66959393b05d8d1f635ae3aafcf6bd4fbf844c86`
- `scripts/register-live-screen-text.py`: `2fb59070204f8d8625d80cdc0d372e58c02a70f3`
- `packages/primecare_ui/lib/src/features/auth/mfa_form.dart`: `c627844751544bf4a4da6c141214c639082e2274`
- `packages/primecare_ui/lib/src/features/auth/mfa_catalog.g.dart`: `0416210260540ccc1024a63123b97174c7f72119`
- `packages/primecare_ui/lib/src/features/auth/mfa_management_form.dart`: `2fa22fd52bec13cab88dacbf7f94f2d550bf1a6d`
- `packages/shared/src/auth-mfa.json`: `48c28c432edb31ee07b53577323b88889161d108`
- `packages/shared/src/auth-lifecycle.json`: `88b63c4ee8cfa0d21c146dca6732dbbab641fdb9`
