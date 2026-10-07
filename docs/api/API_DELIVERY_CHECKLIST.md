# Finite API delivery checklist

One exact HTTP method + path; field repairs and test totals do not increment completed operations.

Baseline: **1415 unique operations**; 1411 active, 4 retired with evidence. 1412 active declarations; 1 duplicate declaration row.

| Evidence stage | Unique operations |
| --- | ---: |
| blocked | 10 |
| needs_contract_and_verification | 1058 |
| retired_with_evidence | 4 |
| unit_evidence_recorded | 343 |

Unit evidence is a completed test milestone, not proof of complete business workflows or deployment. PostgreSQL CI has passed globally, but this checklist does not invent operation-specific coverage. Production status remains unverified here.

## Completion rule

An operation earns one completed API credit only when its exact method/path and callers are reconciled, its handler and registered authority/request/response contracts exist, its unit/negative authorization tests pass, and operation-specific PostgreSQL evidence is linked. Deployment and authenticated production checks are separate release gates. Duplicate/stale declarations must be retired with recorded rationale rather than implemented blindly. A POST declaration is not automatically a business write.

## First finite work package

**14/14 reviewed; 6/14 resolved: Reconcile legacy auth declarations with existing handlers and callers.**

The work-package denominator is fixed; a missing declaration only resolves through a documented retirement with evidence. Check handler and gateway behavior, caller methods and schema/authority registration for each item. Record one disposition per operation: verify implementation, implement a justified missing operation, or retire/replace a stale declaration. No broad access grants may be inferred from a catalog label.

- [x] POST /v1/auth
- [x] POST /v1/auth/
- [x] POST /v1/auth/forgot-password
- [ ] POST /v1/auth/impersonate
- [x] POST /v1/auth/login
- [x] POST /v1/auth/logout
- [ ] POST /v1/auth/onboard-business
- [ ] POST /v1/auth/osm
- [ ] POST /v1/auth/osm/callback
- [ ] POST /v1/auth/profile
- [ ] POST /v1/auth/refresh
- [x] POST /v1/auth/reset-password
- [ ] POST /v1/auth/switch-role
- [ ] POST /v1/auth/whoami

## Next finite work package

**1/1 reviewed; 1/1 resolved: Client booking request submission compatibility.**

- [x] POST /v1/client/bookings/request

## Next finite work package

**1/1 reviewed; 1/1 resolved: Legacy client booking request action routing.**

- [x] POST /v1/client/bookings/requests

## Next finite work package

**1/1 reviewed; 1/1 resolved: Client booking collection submission reconciliation.**

- [x] POST /v1/client/bookings

## Next finite work package

**2/2 reviewed; 2/2 resolved: Retire unused client profile and invoice POST read declarations.**

- [x] POST /v1/client/home/profile
- [x] POST /v1/client/invoices

## Work by route area

| Area | Baseline | Unit evidence | Needs work | Blocked | Retired |
| --- | ---: | ---: | ---: | ---: | ---: |
| adjustment-notes | 1 | 0 | 1 | 0 | 0 |
| admin | 252 | 7 | 245 | 0 | 0 |
| agent-dispatch | 1 | 0 | 1 | 0 | 0 |
| ai | 9 | 0 | 9 | 0 | 0 |
| allied | 1 | 0 | 1 | 0 | 0 |
| analytics | 10 | 0 | 10 | 0 | 0 |
| api-health-dashboard | 1 | 0 | 1 | 0 | 0 |
| api-monitoring | 1 | 0 | 1 | 0 | 0 |
| applicant-tracking | 1 | 0 | 1 | 0 | 0 |
| appointment | 1 | 0 | 1 | 0 | 0 |
| appointment-overview | 1 | 0 | 1 | 0 | 0 |
| assessment | 1 | 0 | 1 | 0 | 0 |
| attendance | 1 | 0 | 1 | 0 | 0 |
| audit-review | 1 | 0 | 1 | 0 | 0 |
| auth | 109 | 99 | 8 | 0 | 2 |
| billing | 2 | 0 | 2 | 0 | 0 |
| billing-overview | 1 | 0 | 1 | 0 | 0 |
| booking | 1 | 0 | 1 | 0 | 0 |
| branch-performance | 1 | 0 | 1 | 0 | 0 |
| brand-management | 1 | 0 | 1 | 0 | 0 |
| business-development | 1 | 0 | 1 | 0 | 0 |
| calendar-management | 1 | 0 | 1 | 0 | 0 |
| campaign-dashboard | 1 | 0 | 1 | 0 | 0 |
| care-plan | 1 | 0 | 1 | 0 | 0 |
| care-plan-review | 1 | 0 | 1 | 0 | 0 |
| care-updates | 1 | 0 | 1 | 0 | 0 |
| caregiver | 2 | 0 | 2 | 0 | 0 |
| caregiver-client-profile | 1 | 0 | 1 | 0 | 0 |
| caregiver-incident-report | 1 | 0 | 1 | 0 | 0 |
| caregiver-schedule | 1 | 0 | 1 | 0 | 0 |
| caregiver-tasks | 1 | 0 | 1 | 0 | 0 |
| caregiver-visit-notes | 1 | 0 | 1 | 0 | 0 |
| certification-tracking | 1 | 0 | 1 | 0 | 0 |
| cfo-cashflow | 1 | 0 | 1 | 0 | 0 |
| cfo-expenses | 1 | 0 | 1 | 0 | 0 |
| cfo-invoices | 1 | 0 | 1 | 0 | 0 |
| cfo-payroll | 1 | 0 | 1 | 0 | 0 |
| cfo-profitability | 1 | 0 | 1 | 0 | 0 |
| cfo-revenue | 1 | 0 | 1 | 0 | 0 |
| cfo-tax | 1 | 0 | 1 | 0 | 0 |
| chiropractic-assessment | 1 | 0 | 1 | 0 | 0 |
| chiropractic-progress-tracking | 1 | 0 | 1 | 0 | 0 |
| chiropractor-appointments | 1 | 0 | 1 | 0 | 0 |
| chiropractor-assessment | 1 | 0 | 1 | 0 | 0 |
| chiropractor-billing-link | 1 | 0 | 1 | 0 | 0 |
| chiropractor-client-intake | 1 | 0 | 1 | 0 | 0 |
| chiropractor-command-center | 1 | 0 | 1 | 0 | 0 |
| chiropractor-exercise-plan | 1 | 0 | 1 | 0 | 0 |
| chiropractor-reports | 1 | 0 | 1 | 0 | 0 |
| chiropractor-treatment-notes | 1 | 0 | 1 | 0 | 0 |
| cisoanalytics | 1 | 0 | 1 | 0 | 0 |
| cisoworkflow | 1 | 0 | 1 | 0 | 0 |
| claims-processing | 1 | 0 | 1 | 0 | 0 |
| client | 121 | 97 | 22 | 0 | 2 |
| client-intake | 1 | 0 | 1 | 0 | 0 |
| client-issue | 1 | 0 | 1 | 0 | 0 |
| client-progress | 1 | 0 | 1 | 0 | 0 |
| clinical | 6 | 0 | 6 | 0 | 0 |
| clinical-director-approvals | 1 | 0 | 1 | 0 | 0 |
| clinical-director-compliance | 1 | 0 | 1 | 0 | 0 |
| clinical-director-incident-review | 1 | 0 | 1 | 0 | 0 |
| clinical-director-performance | 1 | 0 | 1 | 0 | 0 |
| clinical-director-reports | 1 | 0 | 1 | 0 | 0 |
| clinical-director-staff-quality | 1 | 0 | 1 | 0 | 0 |
| clinical-operations4-k | 1 | 0 | 1 | 0 | 0 |
| clinical-quality | 1 | 0 | 1 | 0 | 0 |
| cns | 2 | 0 | 2 | 0 | 0 |
| cns-analytics | 1 | 0 | 1 | 0 | 0 |
| cns-workflow | 1 | 0 | 1 | 0 | 0 |
| communication | 1 | 0 | 1 | 0 | 0 |
| communityoutreachanalytics | 1 | 0 | 1 | 0 | 0 |
| communityoutreachworkflow | 1 | 0 | 1 | 0 | 0 |
| compliance-dashboard | 1 | 0 | 1 | 0 | 0 |
| compliance-overview | 1 | 0 | 1 | 0 | 0 |
| compliance-review | 1 | 0 | 1 | 0 | 0 |
| concierge | 2 | 0 | 2 | 0 | 0 |
| conflict-resolution | 1 | 0 | 1 | 0 | 0 |
| coo-branch-comparison | 1 | 0 | 1 | 0 | 0 |
| coo-command-center | 1 | 0 | 1 | 0 | 0 |
| coo-operations-overview | 1 | 0 | 1 | 0 | 0 |
| coo-scheduling-health | 1 | 0 | 1 | 0 | 0 |
| coo-staffing | 1 | 0 | 1 | 0 | 0 |
| coo-workflow-issues | 1 | 0 | 1 | 0 | 0 |
| coordinator | 19 | 0 | 19 | 0 | 0 |
| corrective-action | 1 | 0 | 1 | 0 | 0 |
| course-assignment | 1 | 0 | 1 | 0 | 0 |
| credential-expiry | 1 | 0 | 1 | 0 | 0 |
| cron | 1 | 0 | 1 | 0 | 0 |
| cx-director-analytics | 1 | 0 | 1 | 0 | 0 |
| cx-director-workflow | 1 | 0 | 1 | 0 | 0 |
| daily-operations | 1 | 0 | 1 | 0 | 0 |
| debug | 2 | 0 | 2 | 0 | 0 |
| defect-tracking | 1 | 0 | 1 | 0 | 0 |
| deployment-center | 1 | 0 | 1 | 0 | 0 |
| documents | 1 | 0 | 1 | 0 | 0 |
| drift-findings | 1 | 0 | 1 | 0 | 0 |
| dynamicworkflow | 1 | 0 | 1 | 0 | 0 |
| education | 10 | 0 | 10 | 0 | 0 |
| emergency-contacts | 1 | 0 | 1 | 0 | 0 |
| employee | 2 | 0 | 2 | 0 | 0 |
| employee-analytics | 1 | 0 | 1 | 0 | 0 |
| employee-records | 1 | 0 | 1 | 0 | 0 |
| employee-workflow | 1 | 0 | 1 | 0 | 0 |
| enterprise-command-center4-k | 1 | 0 | 1 | 0 | 0 |
| enterprise-health | 1 | 0 | 1 | 0 | 0 |
| executive | 2 | 0 | 2 | 0 | 0 |
| executive-command-center | 1 | 0 | 1 | 0 | 0 |
| exercise-prescription | 1 | 0 | 1 | 0 | 0 |
| expense-management | 1 | 0 | 1 | 0 | 0 |
| failed-workflow | 1 | 0 | 1 | 0 | 0 |
| family-overview | 1 | 0 | 1 | 0 | 0 |
| features | 1 | 0 | 1 | 0 | 0 |
| file-verification-dashboard | 1 | 0 | 1 | 0 | 0 |
| finance | 3 | 0 | 3 | 0 | 0 |
| finance-director-analytics | 1 | 0 | 1 | 0 | 0 |
| finance-director-workflow | 1 | 0 | 1 | 0 | 0 |
| financial-dashboard | 1 | 0 | 1 | 0 | 0 |
| financial-operations4-k | 1 | 0 | 1 | 0 | 0 |
| followup | 1 | 0 | 1 | 0 | 0 |
| franchise-command-center | 1 | 0 | 1 | 0 | 0 |
| franchise-command-center4-k | 1 | 0 | 1 | 0 | 0 |
| franchise-lead | 1 | 0 | 1 | 0 | 0 |
| franchise-overview | 1 | 0 | 1 | 0 | 0 |
| franchise-owner-appointments | 1 | 0 | 1 | 0 | 0 |
| franchise-owner-branch-overview | 1 | 0 | 1 | 0 | 0 |
| franchise-owner-clients | 1 | 0 | 1 | 0 | 0 |
| franchise-owner-command-center | 1 | 0 | 1 | 0 | 0 |
| franchise-owner-compliance | 1 | 0 | 1 | 0 | 0 |
| franchise-owner-finance-snapshot | 1 | 0 | 1 | 0 | 0 |
| franchise-owner-reports | 1 | 0 | 1 | 0 | 0 |
| franchise-owner-staff | 1 | 0 | 1 | 0 | 0 |
| franchise-sales-analytics | 1 | 0 | 1 | 0 | 0 |
| franchise-sales-workflow | 1 | 0 | 1 | 0 | 0 |
| governance | 19 | 16 | 3 | 0 | 0 |
| governance-control-room | 1 | 0 | 1 | 0 | 0 |
| governance-operations4-k | 1 | 0 | 1 | 0 | 0 |
| growth-analytics | 1 | 0 | 1 | 0 | 0 |
| guest-workflow | 1 | 0 | 1 | 0 | 0 |
| health | 2 | 0 | 2 | 0 | 0 |
| hiring-pipeline | 1 | 0 | 1 | 0 | 0 |
| home-care-plan | 1 | 0 | 1 | 0 | 0 |
| hr-director-credential-expiry | 1 | 0 | 1 | 0 | 0 |
| hr-director-hiring-pipeline | 1 | 0 | 1 | 0 | 0 |
| hr-director-onboarding | 1 | 0 | 1 | 0 | 0 |
| hr-director-staff-files | 1 | 0 | 1 | 0 | 0 |
| hr-director-training | 1 | 0 | 1 | 0 | 0 |
| hr-hiring-applicants | 1 | 0 | 1 | 0 | 0 |
| hr-hiring-credentials | 1 | 0 | 1 | 0 | 0 |
| hr-hiring-interviews | 1 | 0 | 1 | 0 | 0 |
| hr-hiring-offers | 1 | 0 | 1 | 0 | 0 |
| hr-hiring-onboarding | 1 | 0 | 1 | 0 | 0 |
| hsw | 3 | 0 | 3 | 0 | 0 |
| incident-management | 1 | 0 | 1 | 0 | 0 |
| incident-oversight | 1 | 0 | 1 | 0 | 0 |
| incident-report | 1 | 0 | 1 | 0 | 0 |
| incident-review | 1 | 0 | 1 | 0 | 0 |
| incidents | 1 | 0 | 1 | 0 | 0 |
| infrastructureanalytics | 1 | 0 | 1 | 0 | 0 |
| infrastructureworkflow | 1 | 0 | 1 | 0 | 0 |
| intake-coordinator-assessment-queue | 1 | 0 | 1 | 0 | 0 |
| intake-coordinator-booking | 1 | 0 | 1 | 0 | 0 |
| intake-coordinator-documents | 1 | 0 | 1 | 0 | 0 |
| intake-coordinator-follow-up | 1 | 0 | 1 | 0 | 0 |
| intake-coordinator-new-client-intake | 1 | 0 | 1 | 0 | 0 |
| intake-coordinator-referrals | 1 | 0 | 1 | 0 | 0 |
| interop | 3 | 0 | 3 | 0 | 0 |
| interview-scheduling | 1 | 0 | 1 | 0 | 0 |
| invoice-management | 1 | 0 | 1 | 0 | 0 |
| lead-analytics | 1 | 0 | 1 | 0 | 0 |
| legalanalytics | 1 | 0 | 1 | 0 | 0 |
| legalworkflow | 1 | 0 | 1 | 0 | 0 |
| lpn | 2 | 0 | 2 | 0 | 0 |
| lpn-analytics | 1 | 0 | 1 | 0 | 0 |
| lpn-workflow | 1 | 0 | 1 | 0 | 0 |
| manager | 42 | 0 | 42 | 0 | 0 |
| marketing | 12 | 0 | 12 | 0 | 0 |
| massage-assessment | 1 | 0 | 1 | 0 | 0 |
| medication | 1 | 0 | 1 | 0 | 0 |
| medication-administration | 1 | 0 | 1 | 0 | 0 |
| messages | 2 | 0 | 2 | 0 | 0 |
| messaging | 1 | 0 | 1 | 0 | 0 |
| np | 2 | 0 | 2 | 0 | 0 |
| np-analytics | 1 | 0 | 1 | 0 | 0 |
| np-workflow | 1 | 0 | 1 | 0 | 0 |
| nursing-task | 1 | 0 | 1 | 0 | 0 |
| offer-management | 1 | 0 | 1 | 0 | 0 |
| office | 1 | 0 | 1 | 0 | 0 |
| onboarding | 1 | 0 | 1 | 0 | 0 |
| onboarding-checklist | 1 | 0 | 1 | 0 | 0 |
| open-shift | 1 | 0 | 1 | 0 | 0 |
| operations | 1 | 0 | 1 | 0 | 0 |
| operations-command-center | 1 | 0 | 1 | 0 | 0 |
| ops | 3 | 0 | 3 | 0 | 0 |
| other | 10 | 0 | 0 | 10 | 0 |
| outreach-campaign | 1 | 0 | 1 | 0 | 0 |
| partnership-management | 1 | 0 | 1 | 0 | 0 |
| patient-appointments | 1 | 0 | 1 | 0 | 0 |
| patient-billing | 1 | 0 | 1 | 0 | 0 |
| patient-care-plan | 1 | 0 | 1 | 0 | 0 |
| patient-charting | 1 | 0 | 1 | 0 | 0 |
| patient-command-center | 1 | 0 | 1 | 0 | 0 |
| patient-documents | 1 | 0 | 1 | 0 | 0 |
| patient-messages | 1 | 0 | 1 | 0 | 0 |
| patient-observation | 1 | 0 | 1 | 0 | 0 |
| patient-profile | 1 | 0 | 1 | 0 | 0 |
| payment-tracking | 1 | 0 | 1 | 0 | 0 |
| payroll | 1 | 0 | 1 | 0 | 0 |
| pediatric | 2 | 0 | 2 | 0 | 0 |
| pediatric-analytics | 1 | 0 | 1 | 0 | 0 |
| pediatric-workflow | 1 | 0 | 1 | 0 | 0 |
| pending-task-queue | 1 | 0 | 1 | 0 | 0 |
| physician | 2 | 0 | 2 | 0 | 0 |
| physician-analytics | 1 | 0 | 1 | 0 | 0 |
| physician-workflow | 1 | 0 | 1 | 0 | 0 |
| physiotherapist-appointments | 1 | 0 | 1 | 0 | 0 |
| physiotherapist-assessment | 1 | 0 | 1 | 0 | 0 |
| physiotherapist-billing-link | 1 | 0 | 1 | 0 | 0 |
| physiotherapist-client-intake | 1 | 0 | 1 | 0 | 0 |
| physiotherapist-command-center | 1 | 0 | 1 | 0 | 0 |
| physiotherapist-exercise-plan | 1 | 0 | 1 | 0 | 0 |
| physiotherapist-reports | 1 | 0 | 1 | 0 | 0 |
| physiotherapist-treatment-notes | 1 | 0 | 1 | 0 | 0 |
| policy-management | 1 | 0 | 1 | 0 | 0 |
| portal-analytics | 1 | 0 | 1 | 0 | 0 |
| portal-workflow | 1 | 0 | 1 | 0 | 0 |
| premium | 251 | 72 | 179 | 0 | 0 |
| premium-concierge-analytics | 1 | 0 | 1 | 0 | 0 |
| premium-concierge-workflow | 1 | 0 | 1 | 0 | 0 |
| progress-tracking | 1 | 0 | 1 | 0 | 0 |
| provider | 52 | 49 | 3 | 0 | 0 |
| psw | 42 | 0 | 42 | 0 | 0 |
| psw-care-plan | 1 | 0 | 1 | 0 | 0 |
| psw-client-profile | 1 | 0 | 1 | 0 | 0 |
| psw-command-center | 1 | 0 | 1 | 0 | 0 |
| psw-documents | 1 | 0 | 1 | 0 | 0 |
| psw-incident-report | 1 | 0 | 1 | 0 | 0 |
| psw-messages | 1 | 0 | 1 | 0 | 0 |
| psw-my-shifts | 1 | 0 | 1 | 0 | 0 |
| psw-visit-notes | 1 | 0 | 1 | 0 | 0 |
| psw-vitals-log | 1 | 0 | 1 | 0 | 0 |
| public | 8 | 0 | 8 | 0 | 0 |
| quality-audit | 1 | 0 | 1 | 0 | 0 |
| referral-management | 1 | 0 | 1 | 0 | 0 |
| refund-management | 1 | 0 | 1 | 0 | 0 |
| regionalbdmanalytics | 1 | 0 | 1 | 0 | 0 |
| regionalbdmworkflow | 1 | 0 | 1 | 0 | 0 |
| regionalmanagerusaanalytics | 1 | 0 | 1 | 0 | 0 |
| regionalmanagerusaworkflow | 1 | 0 | 1 | 0 | 0 |
| release-management | 1 | 0 | 1 | 0 | 0 |
| release-operations | 1 | 0 | 1 | 0 | 0 |
| resolution-tracking | 1 | 0 | 1 | 0 | 0 |
| responsive-preview | 1 | 0 | 1 | 0 | 0 |
| revenue | 1 | 0 | 1 | 0 | 0 |
| revenue-analytics | 1 | 0 | 1 | 0 | 0 |
| revenue-snapshot | 1 | 0 | 1 | 0 | 0 |
| risk-management | 1 | 0 | 1 | 0 | 0 |
| rmt | 4 | 0 | 4 | 0 | 0 |
| rmt-appointments | 1 | 0 | 1 | 0 | 0 |
| rmt-assessment | 1 | 0 | 1 | 0 | 0 |
| rmt-billing-link | 1 | 0 | 1 | 0 | 0 |
| rmt-client-intake | 1 | 0 | 1 | 0 | 0 |
| rmt-command-center | 1 | 0 | 1 | 0 | 0 |
| rmt-exercise-plan | 1 | 0 | 1 | 0 | 0 |
| rmt-reports | 1 | 0 | 1 | 0 | 0 |
| rmt-treatment-notes | 1 | 0 | 1 | 0 | 0 |
| rn | 22 | 0 | 22 | 0 | 0 |
| rn-care-plan-review | 1 | 0 | 1 | 0 | 0 |
| rn-command-center | 1 | 0 | 1 | 0 | 0 |
| rn-field-supervisor-analytics | 1 | 0 | 1 | 0 | 0 |
| rn-field-supervisor-workflow | 1 | 0 | 1 | 0 | 0 |
| rn-incident-review | 1 | 0 | 1 | 0 | 0 |
| rn-medications | 1 | 0 | 1 | 0 | 0 |
| rn-patient-charting | 1 | 0 | 1 | 0 | 0 |
| rn-reports | 1 | 0 | 1 | 0 | 0 |
| rn-tasks | 1 | 0 | 1 | 0 | 0 |
| rn-vitals | 1 | 0 | 1 | 0 | 0 |
| role-coverage-dashboard | 1 | 0 | 1 | 0 | 0 |
| rpn-care-plan-review | 1 | 0 | 1 | 0 | 0 |
| rpn-command-center | 1 | 0 | 1 | 0 | 0 |
| rpn-incident-review | 1 | 0 | 1 | 0 | 0 |
| rpn-medications | 1 | 0 | 1 | 0 | 0 |
| rpn-patient-charting | 1 | 0 | 1 | 0 | 0 |
| rpn-reports | 1 | 0 | 1 | 0 | 0 |
| rpn-tasks | 1 | 0 | 1 | 0 | 0 |
| rpn-vitals | 1 | 0 | 1 | 0 | 0 |
| runtime-verification | 1 | 0 | 1 | 0 | 0 |
| saas | 2 | 0 | 2 | 0 | 0 |
| schedule | 1 | 0 | 1 | 0 | 0 |
| scheduler-booking-requests | 1 | 0 | 1 | 0 | 0 |
| scheduler-calendar | 1 | 0 | 1 | 0 | 0 |
| scheduler-command-center | 1 | 0 | 1 | 0 | 0 |
| scheduler-conflicts | 1 | 0 | 1 | 0 | 0 |
| scheduler-open-shifts | 1 | 0 | 1 | 0 | 0 |
| scheduler-provider-availability | 1 | 0 | 1 | 0 | 0 |
| scheduling-dashboard | 1 | 0 | 1 | 0 | 0 |
| scheduling-health | 1 | 0 | 1 | 0 | 0 |
| scheduling-operations4-k | 1 | 0 | 1 | 0 | 0 |
| scrum-master | 14 | 0 | 14 | 0 | 0 |
| scrummasteranalytics | 1 | 0 | 1 | 0 | 0 |
| scrummasterworkflow | 1 | 0 | 1 | 0 | 0 |
| security | 7 | 0 | 7 | 0 | 0 |
| security-audit | 1 | 0 | 1 | 0 | 0 |
| service-issue | 1 | 0 | 1 | 0 | 0 |
| service-quality | 1 | 0 | 1 | 0 | 0 |
| shareholder-analytics | 1 | 0 | 1 | 0 | 0 |
| shareholder-workflow | 1 | 0 | 1 | 0 | 0 |
| shift-report | 1 | 0 | 1 | 0 | 0 |
| shift-tasks | 1 | 0 | 1 | 0 | 0 |
| social-media | 1 | 0 | 1 | 0 | 0 |
| socialworkeranalytics | 1 | 0 | 1 | 0 | 0 |
| socialworkerworkflow | 1 | 0 | 1 | 0 | 0 |
| staff | 15 | 0 | 15 | 0 | 0 |
| staff-management | 1 | 0 | 1 | 0 | 0 |
| staff-performance | 1 | 0 | 1 | 0 | 0 |
| staff-progress | 1 | 0 | 1 | 0 | 0 |
| staffing-overview | 1 | 0 | 1 | 0 | 0 |
| superuser | 7 | 0 | 7 | 0 | 0 |
| support | 2 | 0 | 2 | 0 | 0 |
| system | 14 | 0 | 14 | 0 | 0 |
| system-health | 1 | 0 | 1 | 0 | 0 |
| tax-compliance | 1 | 0 | 1 | 0 | 0 |
| telemetry | 1 | 0 | 1 | 0 | 0 |
| test | 1 | 0 | 1 | 0 | 0 |
| testing-overview | 1 | 0 | 1 | 0 | 0 |
| therapist | 2 | 0 | 2 | 0 | 0 |
| therapist-analytics | 1 | 0 | 1 | 0 | 0 |
| therapist-workflow | 1 | 0 | 1 | 0 | 0 |
| ticket-management | 1 | 0 | 1 | 0 | 0 |
| training | 4 | 0 | 4 | 0 | 0 |
| training-dashboard | 1 | 0 | 1 | 0 | 0 |
| training-director-workflow | 1 | 0 | 1 | 0 | 0 |
| training-management | 1 | 0 | 1 | 0 | 0 |
| treatment-notes | 1 | 0 | 1 | 0 | 0 |
| treatment-plan | 1 | 0 | 1 | 0 | 0 |
| user | 8 | 3 | 5 | 0 | 0 |
| verification | 2 | 0 | 2 | 0 | 0 |
| vip | 2 | 0 | 2 | 0 | 0 |
| vip-manager-analytics | 1 | 0 | 1 | 0 | 0 |
| vip-manager-workflow | 1 | 0 | 1 | 0 | 0 |
| visit-notes | 1 | 0 | 1 | 0 | 0 |
| vitals-entry | 1 | 0 | 1 | 0 | 0 |
| vitals-tracking | 1 | 0 | 1 | 0 | 0 |
| volunteer | 2 | 0 | 2 | 0 | 0 |
| workflow-execution | 1 | 0 | 1 | 0 | 0 |
| workflow-issue | 1 | 0 | 1 | 0 | 0 |
| xray-review | 1 | 0 | 1 | 0 | 0 |

Route areas are catalog prefixes, not independently deployed services. The JSON checklist contains every unique operation, source declaration IDs, missing fields and next action. Regenerate through generate-api-execution-inventory.py; never advance this counter for repeated field repairs.
