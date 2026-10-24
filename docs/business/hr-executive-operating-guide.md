# HR and executive operating guide

Status: proposed operating model, not a deployed recruitment or executive dashboard.
Existing department reference codes are listed in `evidence/hr-department-plan.json`.
That plan is not fresh production verification. New screens, APIs and permissions
must first be verified against the pinned production governance registry.

## Department duties and hiring

| Department | Accountable output |
| --- | --- |
| HR Operations | Approved staffing plan, policies, employee case ownership |
| Recruitment | Authorized vacancies, candidate pipeline, interview evidence |
| Onboarding and Credentialing | Verified requirements, signed documents, access requests |
| Learning and Development | Role curriculum, supervised practice, competency evidence |
| People Support and Safety | Confidential concerns, incident follow-up, accommodation workflow |
| Workforce Administration | Accurate roster, schedules, leave and payroll handoffs |

Hiring sequence: manager requests position and budget; authorized approver releases
vacancy; recruiter screens against published job criteria; interviewers use the
same scored questions; manager records a supported decision; authorized HR sends
an offer; accepted offer starts credentialing and onboarding. Preserve withdrawal,
rejection and offer-declined outcomes. Do not automatically hire or reject from AI
scores. Keep candidate information outside ordinary employee and sales access.

Interview template: describe a relevant situation, explain your action, give the
result, and identify what you would improve. Use role-specific practical scenarios
and record evidence against a versioned rubric. Example for reception: a caller
requests private appointment information without completing verification. Assess
privacy, verification, explanation and escalation; an eloquent answer alone is
not evidence of competency.

Onboarding gates: accepted offer, required checks, role credential verification,
approved identity/account creation, least-privilege access, policy acknowledgement,
orientation, role training, supervised practice and independent competency signoff.
The manager owns readiness; HR owns completeness; a qualified reviewer owns
competency acceptance. Missing requirements block readiness rather than being
silently marked complete. Offboarding revokes access and reassigns owned work.

## Dashboard acceptance contracts

| Dashboard | Required information | Meaningful action |
| --- | --- | --- |
| Recruitment | Vacancy, budget approval, stage counts, age in stage, owner, next step | Schedule interview, record rubric, request offer approval |
| Onboarding | Start date, requirement status, expiry, reviewer, blocker | Request missing evidence, review, approve readiness |
| Training | Required modules, due dates, assessment attempts, competency signoff | Assign approved curriculum, schedule supervised practice |
| Risk | Risk, cause, impact, likelihood, controls, owner, review date, residual rating | Assign mitigation, record evidence, escalate, request closure |
| Executive | Cash forecast, capacity, demand, quality, staffing, material risks | Assign owner and due date to a reviewed decision |

Every count must declare time window, tenant scope, source and last refresh.
Unknown data stays unknown. Risk ratings use an approved, versioned matrix; a
numeric score alone cannot certify safety or close an incident. Closure requires
control evidence and an independent authorized reviewer. Confidential HR cases
must not appear in broad executive drilldowns.

## Knowledge base and training

Each article needs an owner, audience, source, effective date, revision, review
date and approval state. Search must enforce access before returning excerpts.
AI answers cite the approved article revision; missing or conflicting guidance
goes to the responsible person. Transcript and candidate text are untrusted data,
not instructions. Track acknowledgement separately from assessed competency.

## CEO selection, growth and board duty

The board selects a CEO against an approved role mandate, company stage,
leadership evidence, financial understanding, operational judgment and references.
Record conflicts, interview evidence, approval and delegated authority. An AI
assistant can prepare evidence and track decisions; it cannot become a corporate
officer or replace the accountable person's judgment.

Growth review: establish demand, validate service quality and unit economics,
confirm staff capacity and cash, run a bounded pilot, compare results with agreed
targets, then decide whether to expand. Avoid treating booked revenue as cash or
unfilled vacancies as capacity.

| Board question | Evidence required for an answer |
| --- | --- |
| Can we fund the next period? | Dated cash forecast, assumptions, downside case, financing actions |
| Is growth profitable and deliverable? | Contribution margin, conversion, retention, staffed capacity |
| What could materially harm the company? | Top risks, control effectiveness, incidents, accountable owners |
| Are people ready to perform their duties? | Staffing gaps, credential status, competency and manager review |
| What decision is required today? | Options, cost, benefit, downside, recommendation and authority |
| Did prior decisions work? | Decision log, owner, deadline, evidence and measured outcome |

Meeting pack: previous actions, operating and financial results, staffing and
quality, material risks, proposed decisions and supporting evidence. Minutes
record decisions, conflicts, owners and deadlines. Follow-up tracks completion
and independent acceptance rather than a self-reported green status.

## Implementation boundary

Use browser -> authenticated API -> scoped service -> PostgreSQL. Reuse the
existing scoped service base, atomic store, optimistic versions and audit events.
Do not place SQL, provider credentials or permissions in browser configuration.
Provider configuration should show secret references and verified health, never
return secret values. No production registration, department creation, recruitment
transition, dashboard deployment or legal compliance claim is made by this guide.
