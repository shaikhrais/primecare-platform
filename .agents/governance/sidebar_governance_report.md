# PrimeCare Sidebar Governance & Quality Dashboard

> [!NOTE]
> This automated dashboard tracks the quality, layout compliance, and backend API integration status for all role-based dashboards in the PrimeCare ecosystem.

This automated governance report compiles split dual-column dashboard structures, verifies active API integrations, and flags pending interface modules.

## 📊 Unified Global Quality & Coverage Metrics

| Dimension | Score | Description |
|-----------|:-----:|-------------|
| **Layout Conformity** | `100.0%` | Code layout matches specifications inside relational SQLite database. |
| **API Connectivity** | `14.1%` | Sidebar items bound to active backend/controller workflows (not mock logs/stubs). |
| **Functional Readiness** | `100.0%` | Total actionable sidebar buttons implemented with non-empty handlers. |

## 📁 Module Directory Quality Breakdowns

| Screen Group | Total Dashboards | Dual-Column | Layout Conformity | API Connectivity | Functional Readiness | Outstanding Fixes |
|--------------|:----------------:|:-----------:|:-----------------:|:----------------:|:--------------------:|:-----------------:|
| **allied** | 2 | 1 | `100.0%` | `37.5%` | `100.0%` | **5** |
| **clinical** | 7 | 1 | `100.0%` | `79.2%` | `100.0%` | **5** |
| **common** | 23 | 1 | `100.0%` | `2.7%` | `100.0%` | **110** |
| **executive** | 11 | 1 | `100.0%` | `4.3%` | `100.0%` | **45** |
| **management** | 17 | 1 | `100.0%` | `7.4%` | `100.0%` | **75** |
| **psw** | 1 | 1 | `100.0%` | `0.0%` | `100.0%` | **5** |
| **rn** | 2 | 1 | `100.0%` | `37.5%` | `100.0%` | **5** |
| **rpn** | 1 | 1 | `100.0%` | `0.0%` | `100.0%` | **5** |
| **staff** | 11 | 1 | `100.0%` | `14.0%` | `100.0%` | **37** |

## 👥 Complete Apps & User Roles Directory
Here is the directory of all 55+ user roles within the PrimeCare platform, categorized by their corresponding Screen Groups on disk:

### 📂 `ALLIED` Screen Group
* **Corresponding Roles:** Chiropractor (`chiropractor`), Physiotherapist (`physio`), Registered Massage Therapist (RMT) (`rmt`), Social Worker (`social_worker`), Therapist (`therapist`)
* **Dashboard Count:** 2 physical dashboard screens built.

### 📂 `CLINICAL` Screen Group
* **Corresponding Roles:** Clinical Director (`clinical_director`), Intake Coordinator (`intake`), Registered Nurse (RN) (`rn`), Physician (`physician`), Clinical Nurse Specialist (`cns`), Pediatric Specialist (`pediatric`)
* **Dashboard Count:** 7 physical dashboard screens built.

### 📂 `COMMON` Screen Group
* **Corresponding Roles:** Caregiver (`caregiver`), Guest (`guest`), Portal User (`portal`), Patient (`patient`), Dynamic Screen Viewer (`dynamic`), Infrastructure Auditor (`infrastructure`), System Verification Officer (`system_verification`), Training Candidate (`training`)
* **Dashboard Count:** 23 physical dashboard screens built.

### 📂 `EXECUTIVE` Screen Group
* **Corresponding Roles:** Chief Executive Officer (CEO) (`ceo`), Chief Financial Officer (CFO) (`cfo`), Chief Information Security Officer (CISO) (`ciso`), Chief Operating Officer (COO) (`coo`), Chief Technology Officer (CTO) (`cto`), CX Director (`cx_director`), Finance Director (`finance_director`), HR Director (`hr_director`), Legal Counsel (`legal`), Franchise Owner (`owner`), Shareholder (`shareholder`), Training Director (`training_director`)
* **Dashboard Count:** 11 physical dashboard screens built.

### 📂 `MANAGEMENT` Screen Group
* **Corresponding Roles:** Community Outreach Lead (`community_outreach`), Compliance Manager (`compliance`), Franchise Sales Manager (`franchise_sales`), General Manager (`gm`), Governance Officer (`governance`), Head of Business Development (`bus_dev`), Head of Marketing (`marketing`), Local Marketing Manager (`local_marketing`), Operations Manager (`ops_manager`), Partnership Manager (`partnership`), Regional BDM (`regional_bdm`), Regional Manager USA (`regional_manager_usa`), Scrum Master (`scrum_master`), Talent Acquisition Manager (`hr_hiring`), Territory Expansion Manager (`territory_expansion`), Territory Sales Manager (`territory_sales`), Volunteer Coordinator (`volunteer_coordinator`)
* **Dashboard Count:** 17 physical dashboard screens built.

### 📂 `PSW` Screen Group
* **Corresponding Roles:** Personal Support Worker (PSW) (`psw`), Home Support Worker (`hsw`)
* **Dashboard Count:** 1 physical dashboard screens built.

### 📂 `RN` Screen Group
* **Corresponding Roles:** Registered Nurse (RN) Field Supervisor (`rn_field_supervisor`), Nurse Practitioner (NP) (`np`)
* **Dashboard Count:** 2 physical dashboard screens built.

### 📂 `RPN` Screen Group
* **Corresponding Roles:** Registered Practical Nurse (RPN) (`rpn`), Licensed Practical Nurse (LPN) (`lpn`)
* **Dashboard Count:** 1 physical dashboard screens built.

### 📂 `STAFF` Screen Group
* **Corresponding Roles:** Employee (`employee`), Volunteer (`volunteer`), Administrative Assistant (`admin`), Shift Supervisor (`scheduler`)
* **Dashboard Count:** 11 physical dashboard screens built.

## 🚨 Anomalies & Architectural Violations
✅ **Zero architectural deviations detected.** Relational SQLite database registry is in perfect alignment with implementation code.

## 🛠️ Master Sidebar Fix Checklist
This actionable checklist lists all mock/stub or pending sidebar items. To resolve an item, edit the screen file, remove the `controller.addLog(...)` call, implement a real controller method call, and run this script to update statistics.

- [ ] **ArchitecturePlanningDashboardController** (`packages/primecare_ui/lib/src/screens/common/architecture_planning_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **BillingAdminDashboardController** (`packages/primecare_ui/lib/src/screens/staff/billing_admin_dashboard_screen.dart`):
  - [ ] Wire action handler `onChanged` to active API/controller method instead of mock: `onChanged: (val) { controller.updateThreshold(...) }`
- [ ] **BusinessDevelopmentDashboardController** (`packages/primecare_ui/lib/src/screens/common/business_development_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **CfoDashboardController** (`packages/primecare_ui/lib/src/screens/executive/cfo_dashboard_screen.dart`):
  - [ ] Wire action handler `onChanged` to active API/controller method instead of mock: `onChanged: (val) { controller.updateThreshold(...) }`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **ChiropractorDashboardController** (`packages/primecare_ui/lib/src/screens/common/chiropractor_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **CisoDashboardController** (`packages/primecare_ui/lib/src/screens/executive/ciso_dashboard_screen.dart`):
  - [ ] Wire action handler `onChanged` to active API/controller method instead of mock: `onChanged: (val) { controller.updateThreshold(...) }`
  - [ ] Wire action handler `onTap_clear_log_consoles` to active API/controller method instead of mock: `() => controller.clearLogs()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.syncPosture()`
- [ ] **ClinicDashboardController** (`packages/primecare_ui/lib/src/screens/common/clinic_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **ClinicalDashboardController** (`packages/primecare_ui/lib/src/screens/clinical/clinical_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **CommunityOutreachDashboardController** (`packages/primecare_ui/lib/src/screens/management/community_outreach_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **ComplianceManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/compliance_manager_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **CourseArchitectDashboardController** (`packages/primecare_ui/lib/src/screens/common/course_architect_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **CtoDashboardController** (`packages/primecare_ui/lib/src/screens/executive/cto_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **CustomerSupportDashboardController** (`packages/primecare_ui/lib/src/screens/common/customer_support_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **CxDirectorDashboardController** (`packages/primecare_ui/lib/src/screens/executive/cx_director_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **DynamicScreenDashboardController** (`packages/primecare_ui/lib/src/screens/common/dynamic_screen_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **FamilyMemberDashboardController** (`packages/primecare_ui/lib/src/screens/common/family_member_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **FinanceDirectorDashboardController** (`packages/primecare_ui/lib/src/screens/executive/finance_director_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **FranchiseDashboardController** (`packages/primecare_ui/lib/src/screens/common/franchise_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **FranchiseSalesManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/franchise_sales_manager_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **GeneralManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/general_manager_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **GovernanceOfficerDashboardController** (`packages/primecare_ui/lib/src/screens/management/governance_officer_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **GuestDashboardController** (`packages/primecare_ui/lib/src/screens/common/guest_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **HeadOfBusDevDashboardController** (`packages/primecare_ui/lib/src/screens/management/head_of_bus_dev_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **HeadOfMarketingDashboardController** (`packages/primecare_ui/lib/src/screens/management/head_of_marketing_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **HrDirectorDashboardController** (`packages/primecare_ui/lib/src/screens/executive/hr_director_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **HrHiringDashboardController** (`packages/primecare_ui/lib/src/screens/staff/hr_hiring_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **HrManagerDashboardController** (`packages/primecare_ui/lib/src/screens/staff/hr_manager_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **InfrastructureDashboardController** (`packages/primecare_ui/lib/src/screens/common/infrastructure_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **IntakeCoordinatorDashboardController** (`packages/primecare_ui/lib/src/screens/staff/intake_coordinator_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **IntakeDashboardController** (`packages/primecare_ui/lib/src/screens/common/intake_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **LegalDashboardController** (`packages/primecare_ui/lib/src/screens/executive/legal_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **LocalMarketingManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/local_marketing_manager_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **OfficeDashboardController** (`packages/primecare_ui/lib/src/screens/common/office_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **OperationsManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/operations_manager_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **OwnerDashboardController** (`packages/primecare_ui/lib/src/screens/executive/owner_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **PartnershipManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/partnership_manager_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **PatientDashboardController** (`packages/primecare_ui/lib/src/screens/common/patient_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **PhysiotherapistDashboardController** (`packages/primecare_ui/lib/src/screens/common/physiotherapist_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **PortalDashboardController** (`packages/primecare_ui/lib/src/screens/common/portal_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **PswDashboardController** (`packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **QaDashboardController** (`packages/primecare_ui/lib/src/screens/common/qa_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **QualityAssuranceDashboardController** (`packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **ReceptionistDashboardController** (`packages/primecare_ui/lib/src/screens/staff/receptionist_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **RegionalBdmDashboardController** (`packages/primecare_ui/lib/src/screens/management/regional_bdm_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **RegionalManagerUsaDashboardController** (`packages/primecare_ui/lib/src/screens/management/regional_manager_usa_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **RmtDashboardController** (`packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **RnDashboardController** (`packages/primecare_ui/lib/src/screens/rn/rn_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **RpnDashboardController** (`packages/primecare_ui/lib/src/screens/rpn/rpn_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **SchedulerDashboardController** (`packages/primecare_ui/lib/src/screens/staff/scheduler_dashboard_screen.dart`):
  - [ ] Wire action handler `onChanged` to active API/controller method instead of mock: `onChanged: (val) { controller.updateThreshold(...) }`
- [ ] **ScrumMasterDashboardController** (`packages/primecare_ui/lib/src/screens/management/scrum_master_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **ShareholderDashboardController** (`packages/primecare_ui/lib/src/screens/executive/shareholder_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **SocialWorkerDashboardController** (`packages/primecare_ui/lib/src/screens/common/social_worker_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **SupportDashboardController** (`packages/primecare_ui/lib/src/screens/common/support_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **SystemDashboardController** (`packages/primecare_ui/lib/src/screens/common/system_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **SystemVerificationDashboardController** (`packages/primecare_ui/lib/src/screens/common/system_verification_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **TerritoryExpansionManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/territory_expansion_manager_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **TerritorySalesManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/territory_sales_manager_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **TrainingCoordinatorDashboardController** (`packages/primecare_ui/lib/src/screens/staff/training_coordinator_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **TrainingDirectorDashboardController** (`packages/primecare_ui/lib/src/screens/executive/training_director_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **TrainingHubDashboardController** (`packages/primecare_ui/lib/src/screens/common/training_hub_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`
- [ ] **VolunteerCoordinatorDashboardController** (`packages/primecare_ui/lib/src/screens/staff/volunteer_coordinator_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_export_logs` to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire action handler `onTap_policy_update` to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire action handler `onTap_run_audit_scan` to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire action handler `onTap_sync_posture` to active API/controller method instead of mock: `() => controller.syncPosture()`
  - [ ] Wire action handler `renderLogs` to active API/controller method instead of mock: `state.logs`

## 📋 Full Master Sidebar Item Catalog

| Screen | Component Widget | Callback / Action Callback | Integration Status | Connected to API |
|--------|------------------|----------------------------|--------------------|------------------|
| `ArchitecturePlanningDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `ArchitecturePlanningDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `ArchitecturePlanningDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `ArchitecturePlanningDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `ArchitecturePlanningDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `BillingAdminDashboardController` | `Threshold Capacity Adjuster` | `onChanged: (val) { controller.updateThreshold(....` | `pending` | 🔴 Mock/Stub |
| `BusinessDevelopmentDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `BusinessDevelopmentDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `BusinessDevelopmentDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `BusinessDevelopmentDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `BusinessDevelopmentDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `CNS Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `Caregiver Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `CfoDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `CfoDashboardController` | `Threshold Capacity Adjuster` | `onChanged: (val) { controller.updateThreshold(....` | `pending` | 🔴 Mock/Stub |
| `ChiropractorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `ChiropractorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `ChiropractorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `ChiropractorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `ChiropractorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `CisoDashboardController` | `Clear Log Consoles` | `() => controller.clearLogs()` | `pending` | 🔴 Mock/Stub |
| `CisoDashboardController` | `Sync Posture` | `state.isLoading ? () {} : () => controller.sync...` | `pending` | 🔴 Mock/Stub |
| `CisoDashboardController` | `Threshold Capacity Adjuster` | `onChanged: (val) { controller.updateThreshold(....` | `pending` | 🔴 Mock/Stub |
| `ClinicDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `ClinicDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `ClinicDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `ClinicDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `ClinicDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `ClinicalDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `ClinicalDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `ClinicalDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `ClinicalDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `ClinicalDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `CommunityOutreachDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `CommunityOutreachDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `CommunityOutreachDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `CommunityOutreachDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `CommunityOutreachDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `ComplianceManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `ComplianceManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `ComplianceManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `ComplianceManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `ComplianceManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `CooDashboardNotifier` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `CooDashboardNotifier` | `Run Audit Scan` | `() => ref.invalidate(cooDashboardProvider)` | `active` | 🟢 Connected |
| `CourseArchitectDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `CourseArchitectDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `CourseArchitectDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `CourseArchitectDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `CourseArchitectDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `CtoDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `CtoDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `CtoDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `CtoDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `CtoDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `CustomerSupportDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `CustomerSupportDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `CustomerSupportDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `CustomerSupportDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `CustomerSupportDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `CxDirectorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `CxDirectorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `CxDirectorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `CxDirectorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `CxDirectorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `DynamicScreenDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `DynamicScreenDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `DynamicScreenDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `DynamicScreenDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `DynamicScreenDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `Employee Self-Service Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `FamilyMemberDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `FamilyMemberDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `FamilyMemberDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `FamilyMemberDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `FamilyMemberDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `FinanceDirectorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `FinanceDirectorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `FinanceDirectorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `FinanceDirectorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `FinanceDirectorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `FranchiseDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `FranchiseDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `FranchiseDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `FranchiseDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `FranchiseDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `FranchiseSalesManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `FranchiseSalesManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `FranchiseSalesManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `FranchiseSalesManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `FranchiseSalesManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `GeneralManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `GeneralManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `GeneralManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `GeneralManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `GeneralManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `GovernanceOfficerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `GovernanceOfficerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `GovernanceOfficerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `GovernanceOfficerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `GovernanceOfficerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `GuestDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `GuestDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `GuestDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `GuestDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `GuestDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `HSW Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `HeadOfBusDevDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `HeadOfBusDevDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `HeadOfBusDevDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `HeadOfBusDevDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `HeadOfBusDevDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `HeadOfMarketingDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `HeadOfMarketingDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `HeadOfMarketingDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `HeadOfMarketingDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `HeadOfMarketingDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `HrDirectorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `HrDirectorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `HrDirectorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `HrDirectorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `HrDirectorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `HrHiringDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `HrHiringDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `HrHiringDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `HrHiringDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `HrHiringDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `HrManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `HrManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `HrManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `HrManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `HrManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `InfrastructureDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `InfrastructureDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `InfrastructureDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `InfrastructureDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `InfrastructureDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `IntakeCoordinatorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `IntakeCoordinatorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `IntakeCoordinatorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `IntakeCoordinatorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `IntakeCoordinatorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `IntakeDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `IntakeDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `IntakeDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `IntakeDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `IntakeDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `LPN Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `LegalDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `LegalDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `LegalDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `LegalDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `LegalDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `LocalMarketingManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `LocalMarketingManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `LocalMarketingManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `LocalMarketingManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `LocalMarketingManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `Nurse Practitioner Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `OfficeDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `OfficeDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `OfficeDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `OfficeDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `OfficeDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `OperationsManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `OperationsManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `OperationsManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `OperationsManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `OperationsManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `OwnerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `OwnerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `OwnerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `OwnerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `OwnerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `PartnershipManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `PartnershipManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `PartnershipManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `PartnershipManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `PartnershipManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `PatientDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `PatientDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `PatientDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `PatientDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `PatientDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `Pediatric Specialist Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `Physician Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `PhysiotherapistDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `PhysiotherapistDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `PhysiotherapistDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `PhysiotherapistDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `PhysiotherapistDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `PortalDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `PortalDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `PortalDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `PortalDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `PortalDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `Premium Concierge Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `PswDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `PswDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `PswDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `PswDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `PswDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `QaDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `QaDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `QaDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `QaDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `QaDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `RN Field Supervisor Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `ReceptionistDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `ReceptionistDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `ReceptionistDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `ReceptionistDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `ReceptionistDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `RegionalBdmDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `RegionalBdmDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `RegionalBdmDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `RegionalBdmDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `RegionalBdmDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `RegionalManagerUsaDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `RegionalManagerUsaDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `RegionalManagerUsaDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `RegionalManagerUsaDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `RegionalManagerUsaDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `RmtDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `RmtDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `RmtDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `RmtDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `RmtDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `RnDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `RnDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `RnDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `RnDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `RnDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `RpnDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `RpnDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `RpnDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `RpnDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `RpnDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `SchedulerDashboardController` | `Threshold Capacity Adjuster` | `onChanged: (val) { controller.updateThreshold(....` | `pending` | 🔴 Mock/Stub |
| `ScrumMasterDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `ScrumMasterDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `ScrumMasterDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `ScrumMasterDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `ScrumMasterDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `ShareholderDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `ShareholderDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `ShareholderDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `ShareholderDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `ShareholderDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `SocialWorkerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `SocialWorkerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `SocialWorkerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `SocialWorkerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `SocialWorkerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `SupportDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `SupportDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `SupportDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `SupportDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `SupportDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `SystemDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `SystemDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `SystemDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `SystemDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `SystemDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `SystemVerificationDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `SystemVerificationDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `SystemVerificationDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `SystemVerificationDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `SystemVerificationDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `TerritoryExpansionManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `TerritoryExpansionManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `TerritoryExpansionManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `TerritoryExpansionManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `TerritoryExpansionManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `TerritorySalesManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `TerritorySalesManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `TerritorySalesManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `TerritorySalesManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `TerritorySalesManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `Therapist Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `TrainingCoordinatorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `TrainingCoordinatorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `TrainingCoordinatorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `TrainingCoordinatorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `TrainingCoordinatorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `TrainingDirectorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `TrainingDirectorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `TrainingDirectorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `TrainingDirectorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `TrainingDirectorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `TrainingHubDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `TrainingHubDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `TrainingHubDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `TrainingHubDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `TrainingHubDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |
| `VIP Client Manager Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `Volunteer Portal Dashboard` | `Live Auditing timeline Console` | `state.logs` | `active` | 🟢 Connected |
| `VolunteerCoordinatorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `pending` | 🔴 Mock/Stub |
| `VolunteerCoordinatorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `pending` | 🔴 Mock/Stub |
| `VolunteerCoordinatorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `pending` | 🔴 Mock/Stub |
| `VolunteerCoordinatorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `pending` | 🔴 Mock/Stub |
| `VolunteerCoordinatorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `pending` | 🔴 Mock/Stub |