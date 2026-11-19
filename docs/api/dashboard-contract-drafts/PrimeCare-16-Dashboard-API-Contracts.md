# PrimeCare: 16 dashboard API contract drafts

**Status: drafts for review, not live endpoints or approved permissions.** Registry evidence: b829da63b2eaf3064e7dbdec22c69a9be8afe597.

## Rules shared by all proposed contracts

- The UI calls an authenticated API. The server derives tenant and actor from the session, checks the operation and exact record scope, and denies before accessing data.
- Validate required fields and reject unexpected keys or tenant overrides. Treat outputs listed below as minimal proposals; return no unrelated, identifying or operational details by default. Set no-store for sensitive responses.
- Read-only operations do not write. For proposed mutations: revalidate the referenced record, use a scoped idempotency key and expected revision, and commit the approved operation and audit event together where applicable.
- Proposed status defaults: 401 unauthenticated; 403 unauthorized; 404 scoped record not visible; 400 validation error; 409 stale state or key conflict; 429 throttled; 503 unavailable. A job accepted or clinical record saved does not prove delivery or an external outcome.
- Before activation: approve the exact schema, permission, data source and audit rule; verify positive, denied and cross-tenant cases using fixtures; verify the exact main commit. No new grants or API publishing are bundled.

## Caregiver Dashboard

### `POST /v1/caregiver/activity/log`
- **Request:** assignment, declared activity type, event time, idempotency key
- **Response:** activity receipt
- **Access:** Self + active care assignment
- **Gate:** Confirm authorized activity types and record source

### `POST /v1/caregiver/meds/acknowledge`
- **Request:** existing instruction reference, expected revision, idempotency key
- **Response:** acknowledgement receipt only
- **Access:** Self + assigned instruction visibility
- **Gate:** Confirm acknowledgement policy; never treat it as administration

## Clinical Director Dashboard

### `GET /v1/clinical/dashboard`
- **Request:** No body, filters, or tenant override
- **Response:** assignedVerifiedBranchCount only
- **Access:** Active director + current verified branch grants
- **Gate:** Isolated CI passed; runtime access and selective deploy still unverified; no booking metric

## Cns Dashboard

### `POST /v1/cns/consultations/log`
- **Request:** existing consultation reference, event time, version, idempotency key
- **Response:** consultation receipt
- **Access:** Assigned consultation and tenant
- **Gate:** Verify source, protected record policy and exact permitted data

### `POST /v1/cns/standards/publish`
- **Request:** approved revision reference, expected version, idempotency key
- **Response:** publication status receipt
- **Access:** Explicit publisher and separate approved revision
- **Gate:** Confirm approval, versioning, audience and rollback source

## Compliance Dashboard

### `POST /v1/compliance-dashboard/compliance/scan`
- **Request:** registered scan profile, approved scope, idempotency key
- **Response:** job receipt and status
- **Access:** Authorized compliance operator; scan stays within server scope
- **Gate:** Choose governed scan engine, controls and findings visibility

## Employee Dashboard

### `POST /v1/employee/pto/request`
- **Request:** date range, approved leave type, idempotency key
- **Response:** own leave request receipt
- **Access:** Self within active employment; separate approval
- **Gate:** Verify policy, date semantics and HR system of record

### `POST /v1/employee/tax/download`
- **Request:** own existing document reference
- **Response:** protected download with no-store
- **Access:** Self only; revalidate document ownership on each read
- **Gate:** Verify verified document provider and access/audit rules

## Hsw Dashboard

### `POST /v1/hsw/alerts/trigger`
- **Request:** approved alert reference/category, authorized visit, idempotency key
- **Response:** accepted/failed dispatch receipt
- **Access:** Assigned active visit and explicit dispatch policy
- **Gate:** Confirm recipient and escalation service; a request is not delivery

### `POST /v1/hsw/visits/checkin`
- **Request:** visit reference, expected version, idempotency key
- **Response:** visit state receipt
- **Access:** Own active assignment
- **Gate:** Verify visit state rules and time authority

### `POST /v1/hsw/visits/checkout`
- **Request:** visit reference, expected version, idempotency key
- **Response:** visit state receipt
- **Access:** Own active assignment
- **Gate:** Verify matching check-in and allowed completion rules

## Lpn Dashboard

### `POST /v1/lpn/medpass/log`
- **Request:** existing medication event reference, expected version, idempotency key
- **Response:** record receipt, no medication advice
- **Access:** Explicit clinical permission plus assignment
- **Gate:** Confirm approved medication-event schema, attestation and audit

### `POST /v1/lpn/wounds/submit`
- **Request:** existing assessment reference, approved revision, idempotency key
- **Response:** assessment submission receipt
- **Access:** Explicit clinical permission plus assignment
- **Gate:** Confirm approved assessment schema, source and audit

## Np Dashboard

### `POST /v1/np/diagnostics/sign`
- **Request:** existing diagnostic record, expected revision, idempotency key
- **Response:** signature-state receipt
- **Access:** Qualified authorized signer and assigned case
- **Gate:** Confirm approval workflow and signature requirements; never infer clinical decision

### `POST /v1/np/referrals/create`
- **Request:** approved referral draft reference, expected revision, idempotency key
- **Response:** referral receipt; no assumed delivery
- **Access:** Authorized referrer and assigned case
- **Gate:** Confirm record and delivery provider before enabling submission

## Pediatric Dashboard

### `POST /v1/pediatric/growth/record`
- **Request:** assigned patient and existing growth measurement record reference, revision, idempotency key
- **Response:** record receipt
- **Access:** Assigned patients only; explicit clinical write grant
- **Gate:** Confirm authoritative assignment and validated clinical schema

### `POST /v1/pediatric/vaccines/administer`
- **Request:** existing administration-event reference, verified revision, idempotency key
- **Response:** record receipt; does not authorize administration
- **Access:** Assigned patients only; explicit clinical write grant
- **Gate:** Verify vaccination system of record, credentials and recording policy

## Physician Dashboard

### `POST /v1/physician/labs/authorize`
- **Request:** existing lab order reference, expected revision, idempotency key
- **Response:** authorization receipt
- **Access:** Authorized physician and assigned case
- **Gate:** Confirm order source, sign-off policy and audit

### `POST /v1/physician/prescriptions/submit`
- **Request:** existing signed prescription reference, expected revision, idempotency key
- **Response:** submission status receipt; no inferred dispensing
- **Access:** Authorized physician and assigned case
- **Gate:** Confirm regulated approval and verified submission channel; no prescribing logic

## Rmt Dashboard

### `POST /v1/rmt/appointments/fetch`
- **Request:** bounded window and cursor; decide GET migration
- **Response:** minimal appointment projection and cursor
- **Access:** Own approved appointments within tenant scope
- **Gate:** Verify appointment scope, source timestamps, status filters and method choice

### `POST /v1/rmt/claims/submit`
- **Request:** existing claim draft, expected revision, idempotency key
- **Response:** claim submission receipt
- **Access:** Authorized billing operator and associated encounter
- **Gate:** Confirm claims processor, financial validation and access rules

### `POST /v1/rmt/soap-notes/submit`
- **Request:** existing note draft, expected revision, idempotency key
- **Response:** note submission receipt
- **Access:** Assigned encounter and explicit record-write permission
- **Gate:** Verify clinical record retention and approved schema

### `POST /v1/rmt/treatment-plans/update`
- **Request:** existing plan draft, expected revision, idempotency key
- **Response:** versioned plan revision receipt
- **Access:** Assigned encounter and write grant
- **Gate:** Verify plan lifecycle and approval; no clinical recommendations

## Rn Field Supervisor Dashboard

### `POST /v1/rn/assessments/signoff`
- **Request:** existing assessment, approved version, idempotency key
- **Response:** sign-off receipt
- **Access:** Approved supervisor and assigned case; independence where required
- **Gate:** Verify clinical signoff source and policy

### `POST /v1/rn/audits/submit`
- **Request:** existing audit draft, approved revision, idempotency key
- **Response:** audit submission receipt
- **Access:** Authorized auditor and audit scope
- **Gate:** Verify audit record authority and lifecycle

## Scheduling Dashboard

### `POST /v1/scheduling-dashboard/compliance/scan`
- **Request:** registered scheduling scan profile, approved scope, idempotency key
- **Response:** job receipt and status
- **Access:** Authorized scheduler; only allowed schedule resources
- **Gate:** Verify scan controls; no general compliance permission implied

## Therapist Dashboard

### `POST /v1/therapist/notes/finalize`
- **Request:** owned note draft, expected revision, idempotency key
- **Response:** finalization receipt
- **Access:** Assigned encounter and authorized author/signer
- **Gate:** Verify record finalization and revision policy

### `POST /v1/therapist/sessions/start`
- **Request:** existing session reference, expected version, idempotency key
- **Response:** session state receipt
- **Access:** Own assigned session and explicit state transition permission
- **Gate:** Verify session source and state rules

## Training Dashboard

### `POST /v1/training-dashboard/compliance/scan`
- **Request:** registered training scan profile, approved scope, idempotency key
- **Response:** job receipt and status
- **Access:** Authorized training coordinator; only permitted training records
- **Gate:** Verify completion authority and defined training controls

## Volunteer Dashboard

### `POST /v1/volunteer/shift/checkin`
- **Request:** own shift reference, expected version, idempotency key
- **Response:** shift state receipt
- **Access:** Own active role and assignment
- **Gate:** Confirm volunteer shift ledger and check-in rules

### `POST /v1/volunteer/visits/log`
- **Request:** own authorized visit reference, event type/time, idempotency key
- **Response:** visit-log receipt
- **Access:** Own authorized assignment; least data
- **Gate:** Confirm record scope and event policy; no disclosure of patient notes
