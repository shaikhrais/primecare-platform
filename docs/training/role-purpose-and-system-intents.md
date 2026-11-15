# PrimeCare Training — Your Role, Purpose and Daily Work

**Audience:** Every employee, contractor, manager and authorized company user.  
**Status:** Training documentation and proposed Academy/Help content; **not published in the application**, not an authorization grant, and not a substitute for approved company policies or clinical training.

## Why your role matters

PrimeCare coordinates care, people, scheduling, communication, records and business operations. Every role contributes to safe, timely, accountable service. Your purpose is to perform **only the responsibilities assigned to your actual company role**, communicate concerns promptly, protect confidential information, and maintain accurate records. Ask your supervisor when an assignment, instruction or access right is unclear.

## What every user should learn

1. **My role:** Your official job title, reporting manager, team, service area and expected outcomes, as confirmed by your employer.
2. **My responsibilities:** What you own, what you assist with, and what requires approval or escalation.
3. **My screens:** The registered, authorized screens and sections available to your account. A visible button is not proof of permission.
4. **My daily workflow:** Sign in securely; review assigned work; perform authorized tasks; record outcomes accurately; hand off unresolved items; sign out safely.
5. **My boundaries:** Protect personal and health information; use least-privilege access; do not perform clinical, financial, staffing or administrative approvals outside your authority.
6. **My support:** Where to find published Help guides, role training, your supervisor and incident/escalation procedures.
7. **My progress:** Training completion is recorded only when a registered Academy workflow confirms it. Reading this document alone does not certify competency.

## Role-purpose learning examples (illustrative; supervisor approval required)

| Role family | Why the role exists | Typical learning topics | Approval boundary |
| --- | --- | --- | --- |
| Care worker / PSW | Deliver assigned supportive care and report observations | Assigned visits, documentation, safety, communication, escalation | No independent clinical diagnosis or unassigned care |
| Care coordinator / scheduler | Coordinate approved services and coverage | Scheduling, assignment changes, communication, unresolved shifts | Staffing and service changes only with authorized policy |
| Nurse / regulated clinician | Provide care within professional scope and employer policy | Clinical documentation, safety, consent, handoffs | Licensure, scope and clinical approvals remain authoritative |
| Reception / customer support | Help people access services and route requests | Identity verification, intake, appointments, privacy, escalation | No unauthorized record disclosure or clinical decisions |
| Tenant / operations administrator | Maintain authorized team operations and oversight | Team setup, permitted reporting, task review, issue resolution | No cross-tenant access or unapproved grants |
| Finance / billing | Maintain accurate authorized financial workflows | Ledger review, invoices, reconciliation, dispute escalation | No payment, refund or ledger mutation without explicit grants |
| HR / training | Support staffing, onboarding and competency tracking | Role assignment, required training, policy acknowledgement | No automatic employment discipline or clinical credential award |
| Technology / governance | Maintain system reliability and approved access | Screen registration, API contracts, incident response, audits | No invented permissions, production changes or false verification |

These are **examples**, not the definitive duties of each governed role. The official role-specific lesson must be generated only from approved role descriptions, policies and the live governance registry.

## How a role intent becomes an action in PrimeCare

`Authenticated user → server-confirmed role/tenant → registered screen → required section/element → authorized intent → existing API/workflow → recorded outcome → safe success/error/retry state`

- **AppScreenIntent** describes a screen's route, optional role, dependencies and recovery policy.
- **GovernanceRegistry** records in-memory screen intents; it currently has a single primary intent per role and is **not** a complete multi-screen role entitlement catalogue.
- **GovernanceNavigator** checks dependency readiness before navigation; **it does not itself grant server permissions**.
- The pinned production governance records and backend policies must independently authorize each screen and action.
- A registered or visible screen, a placeholder intent, and a successful UI render **do not prove** the underlying business action works.

## Required lesson structure for every real company role

For each **approved role**, create one reviewed training record with:

| Field | Required content |
| --- | --- |
| Identity | Exact role ID/code, department, supervisor and effective policy version |
| Purpose | One plain-language sentence: “My role helps PrimeCare by …” |
| Outcomes | Approved responsibilities, expected service quality and escalation triggers |
| Daily steps | Start-of-shift, work execution, documentation, handoff and end-of-shift |
| Screen map | Governed screen ID, route, section ID, required elements and resource keys |
| Intent map | Intent ID, trigger, required API/workflow and denied/error behavior |
| Access | Tenant, role, ownership and approval boundaries; never inferred from UI |
| Safety | Privacy, consent, workplace safety and relevant professional scope |
| Training | Approved learning resources, examples, practice scenarios and review owner |
| Evidence | Source policy/registration version, reviewer, review date, translation status and real acceptance results |
| Status | `draft`, `reviewed`, `published`, `retired` — set from actual records, never guessed |

## Suggested learner-facing introduction

> **Welcome to PrimeCare.** Your work helps our team deliver dependable service. This training explains why your role matters, what tasks you are responsible for, which PrimeCare screens you may use, and when to ask for help. Your manager and approved company policies determine your actual responsibilities and access. Complete the assigned lessons, practice safely, and ask questions whenever a task is unclear.

## Publication and quality requirements

- Publish role-specific material only after HR/operations (and clinical leadership where applicable) approves the duties and escalation language.
- Map each lesson to the **existing** Academy/Help screen, section, element, language resource, role and permitted API. Do not invent an endpoint, enrolment, certificate, completion receipt or access grant.
- Provide reviewed English, French and Spanish content, accessible layout, keyboard/screen-reader support and mobile usability before release.
- Never automatically lock employees out, hide shifts, assign penalties or recommend termination based on training scores without approved policy, due process and human review.
- Preserve revision history; show a clear “content unavailable” state where an approved lesson is missing.
- Validate with a real authorized learner account, including denied/cross-tenant cases and independent readback, before marking a module operational.

## Existing source references

- `packages/flutter_core/lib/registry/intents/app_screen_intent.dart`
- `packages/flutter_core/lib/registry/governance_registry.dart`
- `packages/flutter_core/lib/routes/governance_navigator.dart`
- `docs/appearance/pc10-section2-business-proposals.md` (Academy proposal remains draft)
- `docs/knowledge-base/role_master_admin.md` (historical role playbook; validate before reuse)
- `docs/roles/` (historical role-screen inventories; not live authority)
- `tools/governance-production/production-pin.json` (production governance authority)

**Implementation status:** Documentation authored only. The complete live role list, per-role purpose approval, Academy publishing, training completion tracking and runtime acceptance are **not verified** by this document.
