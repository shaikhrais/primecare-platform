# PrimeCare MasterDashboard enforcement audit

**Verified scope:** committed registry snapshot at `c6772fc0`, compared against the strict pilot patch on main `53824cce`. This is an inheritance migration audit, not an authenticated production crawl.

## Actual versus projected

- No production changes from this candidate. The live Tenant Admin pilot is an earlier implementation, outside the canonical dashboard inventory.
- Latest **verified** GitHub run: focused contract, desktop/PostgreSQL and Android passed. iPad passed; the iPhone panel received trusted touch, while a separate blank-page diagnostic timed out. The subsequent candidate removes that diagnostic as a gate and retains real open/close touch checks; exact-commit CI was not verified at audit time.
- Staged strict Tenant Admin rule throws **Dashboard cannot render: its screen must extend MasterDashboard** on a direct shell call. This is an expected negative test, not a production incident.
- **115/115 canonical dashboards are not yet wired to this base**. A blanket enforcement cutover without migration would block their current render paths: 113 share the generic workspace renderer, and two have dedicated renderers.
- **838 non-dashboard entries** (833 governed pages, five account screens) are outside the proposed MasterDashboard rule. Public sign-in and recovery have separate routing and must not be blocked by a dashboard gate.

## Canonical migration list, grouped by registered app

### bd (2)

| Dashboard | Registered path | Migration gap |
| --- | --- | --- |
| Business Development Dashboard (`business_development_dashboard`) | `/common/business-development-dashboard` | Shared workspace adapter missing |
| Head Of Bus Dev Dashboard (`head_of_bus_dev_dashboard`) | `/offices/corporate/roles/head_of_bus_dev/dashboard` | Shared workspace adapter missing |

### ci (48)

| Dashboard | Registered path | Migration gap |
| --- | --- | --- |
| Audit Dashboard (`audit_dashboard`) | `/generated/audit-dashboard` | Shared workspace adapter missing |
| CMETracking Dashboard (`c_m_e_tracking_dashboard`) | `/generated/c-m-e-tracking-dashboard` | Shared workspace adapter missing |
| Campaign Performance Dashboard (`campaign_performance_dashboard`) | `/generated/campaign-performance-dashboard` | Shared workspace adapter missing |
| Care Dashboard (`psw_dashboard`) | `/offices/clinical/roles/psw/dashboard` | Shared workspace adapter missing |
| Care delivery (`care_delivery`) | `/care` | Dedicated adapter missing |
| Caregiver Dashboard (`caregiver_dashboard`) | `/offices/clinical/roles/caregiver/dashboard` | Shared workspace adapter missing |
| Chiropractor Dashboard (`chiropractor_dashboard`) | `/offices/clinical/roles/chiropractor/dashboard` | Shared workspace adapter missing |
| Client Dashboard (`client_dashboard`) | `/generated/client-dashboard` | Shared workspace adapter missing |
| Clinic Dashboard (`clinic_dashboard`) | `/offices/clinical/roles/clinical_director/clinic-dashboard` | Shared workspace adapter missing |
| Clinical Dashboard (`clinical_dashboard`) | `/offices/clinical/roles/clinical_director/dashboard-dup-1` | Shared workspace adapter missing |
| Clinical Director Dashboard (`clinical_director_dashboard`) | `/offices/clinical/roles/clinical_director/dashboard` | Shared workspace adapter missing |
| Clinical Trial Recruitment Dashboard (`clinical_trial_recruitment_dashboard`) | `/generated/clinical-trial-recruitment-dashboard` | Shared workspace adapter missing |
| Cns Dashboard (`cns_dashboard`) | `/clinical/cns-dashboard` | Shared workspace adapter missing |
| Dynamic Dashboard (`dynamic_dashboard`) | `/generated/dynamic-dashboard` | Shared workspace adapter missing |
| Epidemiological Surveillance Dashboard (`epidemiological_surveillance_dashboard`) | `/generated/epidemiological-surveillance-dashboard` | Shared workspace adapter missing |
| Escalation Dashboard (`escalation_dashboard`) | `/support/escalation-dashboard` | Shared workspace adapter missing |
| Family Dashboard (`family_dashboard`) | `/offices/client/roles/family_member/dashboard` | Shared workspace adapter missing |
| Franchise Owner Dashboard (`franchise_owner_dashboard`) | `/offices/franchise/roles/franchise_owner/dashboard` | Shared workspace adapter missing |
| Help Desk Dashboard (`help_desk_dashboard`) | `/support/help-desk-dashboard` | Shared workspace adapter missing |
| Hipaa Audit Dashboard (`hipaa_audit_dashboard`) | `/generated/hipaa-audit-dashboard` | Shared workspace adapter missing |
| Hsw Dashboard (`hsw_dashboard`) | `/clinical/hsw-dashboard` | Shared workspace adapter missing |
| Infection Control Dashboard (`infection_control_dashboard`) | `/generated/infection-control-dashboard` | Shared workspace adapter missing |
| Intake Coordinator Dashboard (`intake_coordinator_dashboard`) | `/offices/clinical/roles/intake_coordinator/dashboard` | Shared workspace adapter missing |
| Intake Dashboard (`intake_dashboard`) | `/offices/clinical/roles/intake_coordinator/dashboard-dup-1` | Shared workspace adapter missing |
| It Admin Dashboard (`it_admin_dashboard`) | `/offices/corporate/roles/it_admin/dashboard` | Shared workspace adapter missing |
| It Administrator Dashboard (`it_administrator_dashboard`) | `/generated/it-administrator-dashboard` | Shared workspace adapter missing |
| Lpn Dashboard (`lpn_dashboard`) | `/clinical/lpn-dashboard` | Shared workspace adapter missing |
| Marketing Manager Dashboard (`marketing_manager_dashboard`) | `/offices/franchise/roles/marketing_manager/dashboard` | Shared workspace adapter missing |
| Np Dashboard (`np_dashboard`) | `/clinical/np-dashboard` | Shared workspace adapter missing |
| Nurse Dashboard (`nurse_dashboard`) | `/generated/nurse-dashboard` | Shared workspace adapter missing |
| Pediatric Dashboard (`pediatric_dashboard`) | `/clinical/pediatric-dashboard` | Shared workspace adapter missing |
| Pharmacy Dispensing Dashboard (`pharmacy_dispensing_dashboard`) | `/generated/pharmacy-dispensing-dashboard` | Shared workspace adapter missing |
| Physician Dashboard (`physician_dashboard`) | `/clinical/physician-dashboard` | Shared workspace adapter missing |
| Physiotherapist Dashboard (`physiotherapist_dashboard`) | `/offices/clinical/roles/physiotherapist/dashboard` | Shared workspace adapter missing |
| Predictive Analytics Dashboard (`predictive_analytics_dashboard`) | `/generated/predictive-analytics-dashboard` | Shared workspace adapter missing |
| Provider Performance Dashboard (`provider_performance_dashboard`) | `/generated/provider-performance-dashboard` | Shared workspace adapter missing |
| Psw Care Dashboard (`psw_care_dashboard`) | `/generated/psw-care-dashboard` | Shared workspace adapter missing |
| Regional Manager Dashboard (`regional_manager_dashboard`) | `/offices/franchise/roles/regional_manager/dashboard` | Shared workspace adapter missing |
| Regional Manager Ontario Dashboard (`regional_manager_ontario_dashboard`) | `/offices/business_development/roles/regional_manager_ontario/dashboard` | Shared workspace adapter missing |
| Remote Patient Monitoring Dashboard (`remote_patient_monitoring_dashboard`) | `/generated/remote-patient-monitoring-dashboard` | Shared workspace adapter missing |
| Rmt Dashboard (`rmt_dashboard`) | `/offices/clinical/roles/rmt/dashboard` | Shared workspace adapter missing |
| Rn Dashboard (`rn_dashboard`) | `/offices/clinical/roles/rn/dashboard` | Shared workspace adapter missing |
| Rn Field Supervisor Dashboard (`rn_field_supervisor_dashboard`) | `/rn/rn-field-supervisor-dashboard` | Shared workspace adapter missing |
| Rpn Dashboard (`rpn_dashboard`) | `/offices/clinical/roles/rpn/dashboard` | Shared workspace adapter missing |
| School Health Program Dashboard (`school_health_program_dashboard`) | `/generated/school-health-program-dashboard` | Shared workspace adapter missing |
| Social Worker Dashboard (`social_worker_dashboard`) | `/offices/clinical/roles/social_worker/dashboard` | Shared workspace adapter missing |
| Therapist Dashboard (`therapist_dashboard`) | `/offices/clinical/roles/therapist/dashboard` | Shared workspace adapter missing |
| Unknown Dashboard (`unknown_dashboard`) | `/generated/unknown-dashboard` | Shared workspace adapter missing |

### cl (29)

| Dashboard | Registered path | Migration gap |
| --- | --- | --- |
| Billing Admin Dashboard (`billing_admin_dashboard`) | `/offices/franchise/roles/billing_admin/dashboard` | Shared workspace adapter missing |
| Compliance Dashboard (`compliance_dashboard`) | `/management/compliance-dashboard` | Shared workspace adapter missing |
| Course Architect Dashboard (`course_architect_dashboard`) | `/common/course-architect-dashboard` | Shared workspace adapter missing |
| Customer Support Dashboard (`customer_support_dashboard`) | `/common/customer-support-dashboard` | Shared workspace adapter missing |
| Dynamic Screen Dashboard (`dynamic_screen_dashboard`) | `/common/dynamic-dashboard` | Shared workspace adapter missing |
| Employee Dashboard (`employee_dashboard`) | `/staff/employee-dashboard` | Shared workspace adapter missing |
| Family Member Dashboard (`family_member_dashboard`) | `/common/family-member-dashboard` | Shared workspace adapter missing |
| General Manager Dashboard (`general_manager_dashboard`) | `/offices/business_development/roles/general_manager/dashboard` | Shared workspace adapter missing |
| Guest Dashboard (`guest_dashboard`) | `/common/guest-dashboard` | Shared workspace adapter missing |
| Infrastructure Dashboard (`infrastructure_dashboard`) | `/common/infrastructure-dashboard` | Shared workspace adapter missing |
| Office Dashboard (`office_dashboard`) | `/common/office-dashboard` | Shared workspace adapter missing |
| Operations Manager Dashboard (`operations_manager_dashboard`) | `/offices/franchise/roles/operations_manager/dashboard` | Shared workspace adapter missing |
| Partnership Manager Dashboard (`partnership_manager_dashboard`) | `/offices/business_development/roles/partnership_manager/dashboard` | Shared workspace adapter missing |
| Patient Dashboard (`patient_dashboard`) | `/offices/client/roles/client/dashboard` | Shared workspace adapter missing |
| Portal Dashboard (`portal_dashboard`) | `/common/portal-dashboard` | Shared workspace adapter missing |
| Qa Dashboard (`qa_dashboard`) | `/offices/support/roles/quality_assurance/dashboard` | Shared workspace adapter missing |
| Quality Assurance Dashboard (`quality_assurance_dashboard`) | `/staff/quality-assurance-dashboard` | Shared workspace adapter missing |
| Receptionist Dashboard (`receptionist_dashboard`) | `/staff/receptionist-dashboard` | Shared workspace adapter missing |
| Regional Bdm Dashboard (`regional_bdm_dashboard`) | `/offices/business_development/roles/regional_bdm/dashboard` | Shared workspace adapter missing |
| Regional Manager Usa Dashboard (`regional_manager_usa_dashboard`) | `/offices/business_development/roles/regional_manager_usa/dashboard` | Shared workspace adapter missing |
| Scheduling Dashboard (`scheduling_dashboard`) | `/staff/scheduling-dashboard` | Shared workspace adapter missing |
| Scrum Master Dashboard (`scrum_master_dashboard`) | `/management/scrum-master-dashboard` | Shared workspace adapter missing |
| Support Dashboard (`support_dashboard`) | `/common/support-dashboard` | Shared workspace adapter missing |
| System Verification Dashboard (`system_verification_dashboard`) | `/common/system-verification-dashboard` | Shared workspace adapter missing |
| Territory Expansion Manager Dashboard (`territory_expansion_manager_dashboard`) | `/offices/business_development/roles/territory_expansion_manager/dashboard` | Shared workspace adapter missing |
| Territory Sales Manager Dashboard (`territory_sales_manager_dashboard`) | `/offices/marketing/roles/territory_sales_manager/dashboard` | Shared workspace adapter missing |
| Training Dashboard (`training_dashboard`) | `/staff/training-dashboard` | Shared workspace adapter missing |
| Training Hub Dashboard (`training_hub_dashboard`) | `/common/training-hub-dashboard` | Shared workspace adapter missing |
| Volunteer Dashboard (`volunteer_dashboard`) | `/staff/volunteer-dashboard` | Shared workspace adapter missing |

### co (17)

| Dashboard | Registered path | Migration gap |
| --- | --- | --- |
| Architecture Planning Dashboard (`architecture_planning_dashboard`) | `/common/architecture-planning-dashboard` | Shared workspace adapter missing |
| Ceo Dashboard (`ceo_dashboard`) | `/offices/corporate/roles/ceo/dashboard` | Shared workspace adapter missing |
| Cfo Dashboard (`cfo_dashboard`) | `/offices/corporate/roles/cfo/dashboard` | Shared workspace adapter missing |
| Ciso Dashboard (`ciso_dashboard`) | `/offices/corporate/roles/ciso/dashboard` | Shared workspace adapter missing |
| Coo Dashboard (`coo_dashboard`) | `/offices/corporate/roles/coo/dashboard` | Shared workspace adapter missing |
| Cto Dashboard (`cto_dashboard`) | `/offices/corporate/roles/cto/dashboard` | Shared workspace adapter missing |
| Cx Director Dashboard (`cx_director_dashboard`) | `/offices/corporate/roles/cx_director/dashboard` | Shared workspace adapter missing |
| Finance Director Dashboard (`finance_director_dashboard`) | `/offices/corporate/roles/finance_director/dashboard` | Shared workspace adapter missing |
| Financial Dashboard (`financial_dashboard`) | `/executive/financial-dashboard` | Shared workspace adapter missing |
| Hr Director Dashboard (`hr_director_dashboard`) | `/offices/corporate/roles/hr_director/dashboard` | Shared workspace adapter missing |
| Hr Hiring Dashboard (`hr_hiring_dashboard`) | `/offices/corporate/roles/hr_hiring/dashboard` | Shared workspace adapter missing |
| Hr Manager Dashboard (`hr_manager_dashboard`) | `/offices/corporate/roles/hr_manager/dashboard` | Shared workspace adapter missing |
| Legal Dashboard (`legal_dashboard`) | `/offices/corporate/roles/legal/dashboard` | Shared workspace adapter missing |
| Owner Dashboard (`owner_dashboard`) | `/offices/corporate/roles/owner/dashboard` | Shared workspace adapter missing |
| Shareholder Dashboard (`shareholder_dashboard`) | `/offices/corporate/roles/shareholder/dashboard` | Shared workspace adapter missing |
| Training Director Dashboard (`training_director_dashboard`) | `/offices/corporate/roles/training_director/dashboard` | Shared workspace adapter missing |
| Volunteer Coordinator Dashboard (`volunteer_coordinator_dashboard`) | `/offices/corporate/roles/volunteer_coordinator/dashboard` | Shared workspace adapter missing |

### fr (4)

| Dashboard | Registered path | Migration gap |
| --- | --- | --- |
| Admin Dashboard (`admin_dashboard`) | `/offices/franchise/roles/admin/dashboard` | Shared workspace adapter missing |
| Franchise Dashboard (`franchise_dashboard`) | `/common/franchise-dashboard` | Shared workspace adapter missing |
| Franchise Sales Manager Dashboard (`franchise_sales_manager_dashboard`) | `/offices/business_development/roles/franchise_sales_manager/dashboard` | Shared workspace adapter missing |
| Scheduler Dashboard (`scheduler_dashboard`) | `/offices/franchise/roles/scheduler/dashboard` | Shared workspace adapter missing |

### go (7)

| Dashboard | Registered path | Migration gap |
| --- | --- | --- |
| Api Health Dashboard (`api_health_dashboard`) | `/common/api-health-dashboard` | Shared workspace adapter missing |
| Compliance Manager Dashboard (`compliance_manager_dashboard`) | `/offices/corporate/roles/compliance_manager/dashboard` | Shared workspace adapter missing |
| File Verification Dashboard (`file_verification_dashboard`) | `/common/file-verification-dashboard` | Shared workspace adapter missing |
| Governance Officer Dashboard (`governance_officer_dashboard`) | `/management/governance-officer-dashboard` | Shared workspace adapter missing |
| Role Coverage Dashboard (`role_coverage_dashboard`) | `/common/role-coverage-dashboard` | Shared workspace adapter missing |
| Screen Progress Dashboard (`screen_progress_dashboard`) | `/management/screen-progress-dashboard` | Shared workspace adapter missing |
| System Dashboard (`system_dashboard`) | `/common/system-dashboard` | Shared workspace adapter missing |

### ma (5)

| Dashboard | Registered path | Migration gap |
| --- | --- | --- |
| Campaign Dashboard (`campaign_dashboard`) | `/management/campaign-dashboard` | Shared workspace adapter missing |
| Community Outreach Dashboard (`community_outreach_dashboard`) | `/offices/marketing/roles/community_outreach/dashboard` | Shared workspace adapter missing |
| Founder Growth Dashboard (`founder_growth_dashboard`) | `/growth` | Dedicated adapter missing |
| Head Of Marketing Dashboard (`head_of_marketing_dashboard`) | `/offices/corporate/roles/head_of_marketing/dashboard` | Shared workspace adapter missing |
| Local Marketing Manager Dashboard (`local_marketing_manager_dashboard`) | `/offices/marketing/roles/local_marketing_manager/dashboard` | Shared workspace adapter missing |

### su (3)

| Dashboard | Registered path | Migration gap |
| --- | --- | --- |
| Premium Concierge Dashboard (`premium_concierge_dashboard`) | `/management/premium-concierge-dashboard` | Shared workspace adapter missing |
| Training Coordinator Dashboard (`training_coordinator_dashboard`) | `/offices/support/roles/training_coordinator/dashboard` | Shared workspace adapter missing |
| Vip Manager Dashboard (`vip_manager_dashboard`) | `/management/vip-manager-dashboard` | Shared workspace adapter missing |

## Next safe cutover order

1. Verify the strict pilot and second test subclass, including bypass rejection, session ownership and device runs.
2. Wire the shared generic workspace adapter once, then verify all 113 registered dashboard entries against it.
3. Adapt Care Delivery and Founder Growth individually; preserve endpoint, role and tenant contracts.
4. Require full dashboard coverage in CI before turning on inheritance enforcement globally. Do not impose it on ordinary records or authentication.
