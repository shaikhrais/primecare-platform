# Master tenant and staff phone calling

The existing registered **PrimeCare Platform Control** tenant is the master
rather than a duplicate tenant. Its approved Code Admin owner remains linked
to it through the existing native account assignment. Four other tenants were
linked as its children at deployment readback. A native PostgreSQL insert trigger
links future tenants automatically. The count can change as tenants are created.

`platform_master_tenant` permits exactly one master and links its existing owner.
`tenant_parent_links` uses the actual tenant ID type and foreign keys. A tenant
cannot be its own child, use a different parent, or form a cycle. Existing
account assignments and tenant data permissions are unchanged. Master membership
does not grant clinical or account access to other tenants.

The user requirement is registered in pinned production `govt_platform_hierarchy_policy`.
The protected workflow verifies the existing registered owner/control tenant,
creates only the two declared business tables and insert trigger, then performs
independent readback from a fresh database connection. Repeated deployments are
idempotent. Edited policies, roots, schema or triggers are preserved and rejected
for reconciliation rather than overwritten.

## Calling

Refresh the existing Chrome tab. In **Platform Administration → Calls**, enter
an E.164 country-code phone number, select **Call phone**, and allow the
microphone. The shared phone panel supplies mute and hangup. Caller ID remains
**+1 647 930 2223**. Selecting a child tenant does not override the caller's own
server-derived account or tenant identity.

Phone dialing is limited to active, explicitly permitted staff roles, including
Code Admin. Current native API permission AND linked-screen view permission are
required on every check. Client, patient and guest roles are excluded from the
staff allowlist; a patient remains denied even if an API grant is accidentally
added. Existing explicit denials are preserved. This adds no clinical messaging
rights and makes no change to incoming phone routing or AI task authority.

The existing Platform Administration screen (1269) hosts only the three native
external-call contracts (prepare, state, end). Provider connect/complete routes
retain their signature-only authentication and receive no user role grants.
Production readback found eight eligible staff roles, 24 API grants and 15 links
across the existing communication and platform screens. Eligibility follows
current active roles and screen grants; not every arbitrary role is a caller.

The browser uses the same inherited `ExternalCallsPanel`, and
`ExternalCallPolicy` extends the current registered endpoint policy. The
staff-only restriction is part of that inherited SQL authorization check.
No browser role guess, client tenant override, policy cache or identity bypass
was introduced. The inherited internal-call SQL remains byte-compatible.

## Verification boundaries

- Five PostgreSQL metadata tests cover exact registration, Code Admin's platform
  grants, patient exclusion, explicit denials and master-policy idempotence/drift.
- Seventeen service, transport, gateway and deployment-plan tests passed.
- Native PostgreSQL HTTP tests cover Code Admin authorization, patient denial
  despite an accidental grant, session expiry, current revocation, cross-tenant
  denial, signature/identity enforcement and server-owned caller ID.
- Both text and UUID hierarchy fixtures verify native foreign keys, repeated
  deployment, automatic future links, denied cycles/foreign parents, client
  ownership denial, account preservation and refusal to overwrite edited triggers.
- Worker/browser media checks retain their existing simulated provider boundaries.
- Production readiness exercises synthetic staff and Code Admin/MFA login and
  visible phone controls, then removes the synthetic records. It never dials.

Deployment receipts are recorded separately. No automated test places a PSTN
call. Real handset audio and call-capacity claims remain unverified. The previous
native Android APK is unchanged; its reported physical installation issue is
separate from the browser/permission and master-tenant changes here.

## Deployed result

The master-tenant feature first shipped from source
`fe0d3928bd050d39fc4a9ed421280875e41164a4`.
[External workflow 40332200589](https://github.com/shaikhrais/primecare-platform/actions/runs/40332200589)
passed all 15 jobs; [internal regression 40332200572](https://github.com/shaikhrais/primecare-platform/actions/runs/40332200572)
passed all 17. The production synthetic Code Admin check completed MFA,
opened Calls from Platform Administration, confirmed an enabled dial pad and
current API access, and removed the synthetic records. No phone was dialed.

[Exact receipts](../../reports/communications/master-tenant-staff-calling-20261026.json)
include current-source job IDs, independent hierarchy/access readback and the
internal relay-media regression. These are scoped workflow checks and do not
mark independent governance review flags approved or assert all repository CI
is green.

## Mobile calling interface

The shared dial pad was refreshed in source
`6fbaf5782db503d9a2b86d935549b0ffae9a7edb`. It uses the existing theme tokens,
a responsive calling card, a server-provided caller-ID display, a large telephone
input and touch-friendly Call/Mute/End controls. Status includes preparing,
calling, ringing, connected, ended and error states, with live announcements.
The number locks while calling. Ending a muted call resets the indicator so Mute
works correctly on the next call. A restored reservation has End available and
Mute disabled until local media exists.

Real-browser simulated-provider checks verify 320, 390, 768 and 1280 px widths,
no horizontal overflow, 48 px minimum button height, ticket-only forwarding,
token renewal, hangup, editable number after ending, and two consecutive calls
with mute reset. Mobile ready/connected fixture screenshots were inspected.
These are not physical Android or real carrier-audio tests. Current grants,
server policy, reservation protocol and incoming routing are unchanged.

[Mobile UI release receipts](../../reports/communications/calling-ui-20261026.json)
record the current deployment and production staff/Code Admin readiness checks.
