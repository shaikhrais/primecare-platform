# PrimeCare Sidebar Governance & Quality Dashboard

> [!NOTE]
> This automated dashboard tracks the quality, layout compliance, and backend API integration status for all role-based dashboards in the PrimeCare ecosystem.

This automated governance report compiles split dual-column dashboard structures, verifies active API integrations, and flags pending interface modules.

## 📊 Unified Global Quality & Coverage Metrics

| Dimension | Score | Description |
|-----------|:-----:|-------------|
| **Layout Conformity** | `100.0%` | Code layout matches specifications inside relational SQLite database. |
| **API Connectivity** | `0.7%` | Sidebar items bound to active backend/controller workflows (not mock logs/stubs). |
| **Functional Readiness** | `100.0%` | Total actionable sidebar buttons implemented with non-empty handlers. |

## 📁 Module Directory Quality Breakdowns

| Screen Group | Total Dashboards | Dual-Column | Layout Conformity | API Connectivity | Functional Readiness | Outstanding Fixes |
|--------------|:----------------:|:-----------:|:-----------------:|:----------------:|:--------------------:|:-----------------:|
| **allied** | 1 | 1 | `100.0%` | `0.0%` | `100.0%` | **5** |
| **clinical** | 1 | 1 | `100.0%` | `0.0%` | `100.0%` | **5** |
| **common** | 22 | 22 | `100.0%` | `0.0%` | `100.0%` | **110** |
| **executive** | 11 | 11 | `100.0%` | `4.3%` | `100.0%` | **45** |
| **management** | 15 | 15 | `100.0%` | `0.0%` | `100.0%` | **75** |
| **psw** | 1 | 1 | `100.0%` | `0.0%` | `100.0%` | **5** |
| **rn** | 1 | 1 | `100.0%` | `0.0%` | `100.0%` | **5** |
| **rpn** | 1 | 1 | `100.0%` | `0.0%` | `100.0%` | **5** |
| **staff** | 9 | 9 | `100.0%` | `0.0%` | `100.0%` | **37** |

## 👥 Complete Apps & User Roles Directory
Here is the directory of all 55+ user roles within the PrimeCare platform, categorized by their corresponding Screen Groups on disk:

### 📂 `ALLIED` Screen Group
* **Corresponding Roles:** Chiropractor, Physiotherapist, Registered Massage Therapist (RMT), Social Worker, Therapist
* **Dashboard Count:** 1 physical dashboard screens built.

### 📂 `CLINICAL` Screen Group
* **Corresponding Roles:** Clinical Director, Intake Coordinator, Registered Nurse (RN), Physician, Clinical Nurse Specialist, Pediatric Specialist
* **Dashboard Count:** 1 physical dashboard screens built.

### 📂 `COMMON` Screen Group
* **Corresponding Roles:** Caregiver, Guest, Portal User, Patient, Dynamic Screen Viewer, Infrastructure Auditor, System Verification Officer, Training Candidate
* **Dashboard Count:** 22 physical dashboard screens built.

### 📂 `EXECUTIVE` Screen Group
* **Corresponding Roles:** Chief Executive Officer (CEO), Chief Financial Officer (CFO), Chief Information Security Officer (CISO), Chief Operating Officer (COO), Chief Technology Officer (CTO), CX Director, Finance Director, HR Director, Legal Counsel, Franchise Owner, Shareholder, Training Director
* **Dashboard Count:** 11 physical dashboard screens built.

### 📂 `MANAGEMENT` Screen Group
* **Corresponding Roles:** Community Outreach Lead, Compliance Manager, Franchise Sales Manager, General Manager, Governance Officer, Head of Business Development, Head of Marketing, Local Marketing Manager, Operations Manager, Partnership Manager, Regional BDM, Regional Manager USA, Scrum Master, Talent Acquisition Manager, Territory Expansion Manager, Territory Sales Manager, Volunteer Coordinator
* **Dashboard Count:** 15 physical dashboard screens built.

### 📂 `PSW` Screen Group
* **Corresponding Roles:** Personal Support Worker (PSW), Home Support Worker
* **Dashboard Count:** 1 physical dashboard screens built.

### 📂 `RN` Screen Group
* **Corresponding Roles:** Registered Nurse (RN) Field Supervisor, Nurse Practitioner (NP)
* **Dashboard Count:** 1 physical dashboard screens built.

### 📂 `RPN` Screen Group
* **Corresponding Roles:** Registered Practical Nurse (RPN), Licensed Practical Nurse (LPN)
* **Dashboard Count:** 1 physical dashboard screens built.

### 📂 `STAFF` Screen Group
* **Corresponding Roles:** Employee, Volunteer, Administrative Assistant, Shift Supervisor
* **Dashboard Count:** 9 physical dashboard screens built.

## 🚨 Anomalies & Architectural Violations
✅ **Zero architectural deviations detected.** Relational SQLite database registry is in perfect alignment with implementation code.

## 🛠️ Master Sidebar Fix Checklist
This actionable checklist lists all mock/stub or pending sidebar items. To resolve an item, edit the screen file, remove the `controller.addLog(...)` call, implement a real controller method call, and run this script to update statistics.

### 📁 Module: `allied`
- [ ] **RmtDashboardController** (`packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
### 📁 Module: `clinical`
- [ ] **ClinicalDashboardController** (`packages/primecare_ui/lib/src/screens/clinical/clinical_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
### 📁 Module: `common`
- [ ] **ArchitecturePlanningDashboardController** (`packages/primecare_ui/lib/src/screens/common/architecture_planning_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **BusinessDevelopmentDashboardController** (`packages/primecare_ui/lib/src/screens/common/business_development_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **ChiropractorDashboardController** (`packages/primecare_ui/lib/src/screens/common/chiropractor_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **ClinicDashboardController** (`packages/primecare_ui/lib/src/screens/common/clinic_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **CourseArchitectDashboardController** (`packages/primecare_ui/lib/src/screens/common/course_architect_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **CustomerSupportDashboardController** (`packages/primecare_ui/lib/src/screens/common/customer_support_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **DynamicScreenDashboardController** (`packages/primecare_ui/lib/src/screens/common/dynamic_screen_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **FamilyMemberDashboardController** (`packages/primecare_ui/lib/src/screens/common/family_member_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **FranchiseDashboardController** (`packages/primecare_ui/lib/src/screens/common/franchise_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **GuestDashboardController** (`packages/primecare_ui/lib/src/screens/common/guest_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **InfrastructureDashboardController** (`packages/primecare_ui/lib/src/screens/common/infrastructure_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **IntakeDashboardController** (`packages/primecare_ui/lib/src/screens/common/intake_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **OfficeDashboardController** (`packages/primecare_ui/lib/src/screens/common/office_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **PatientDashboardController** (`packages/primecare_ui/lib/src/screens/common/patient_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **PhysiotherapistDashboardController** (`packages/primecare_ui/lib/src/screens/common/physiotherapist_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **PortalDashboardController** (`packages/primecare_ui/lib/src/screens/common/portal_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **QaDashboardController** (`packages/primecare_ui/lib/src/screens/common/qa_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **SocialWorkerDashboardController** (`packages/primecare_ui/lib/src/screens/common/social_worker_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **SupportDashboardController** (`packages/primecare_ui/lib/src/screens/common/support_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **SystemDashboardController** (`packages/primecare_ui/lib/src/screens/common/system_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **SystemVerificationDashboardController** (`packages/primecare_ui/lib/src/screens/common/system_verification_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **TrainingHubDashboardController** (`packages/primecare_ui/lib/src/screens/common/training_hub_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
### 📁 Module: `executive`
- [ ] **CfoDashboardController** (`packages/primecare_ui/lib/src/screens/executive/cfo_dashboard_screen.dart`):
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Threshold Capacity Adjuster` (`ID: capacity_slider`) to active API/controller method instead of mock: `onChanged: (val) { controller.updateThreshold(...) }`
- [ ] **CisoDashboardController** (`packages/primecare_ui/lib/src/screens/executive/ciso_dashboard_screen.dart`):
  - [ ] Wire `Clear Log Consoles` (`ID: clear_log_consoles`) to active API/controller method instead of mock: `() => controller.clearLogs()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.syncPosture()`
  - [ ] Wire `Threshold Capacity Adjuster` (`ID: capacity_slider`) to active API/controller method instead of mock: `onChanged: (val) { controller.updateThreshold(...) }`
- [ ] **CtoDashboardController** (`packages/primecare_ui/lib/src/screens/executive/cto_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **CxDirectorDashboardController** (`packages/primecare_ui/lib/src/screens/executive/cx_director_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **FinanceDirectorDashboardController** (`packages/primecare_ui/lib/src/screens/executive/finance_director_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **HrDirectorDashboardController** (`packages/primecare_ui/lib/src/screens/executive/hr_director_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **LegalDashboardController** (`packages/primecare_ui/lib/src/screens/executive/legal_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **OwnerDashboardController** (`packages/primecare_ui/lib/src/screens/executive/owner_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **ShareholderDashboardController** (`packages/primecare_ui/lib/src/screens/executive/shareholder_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **TrainingDirectorDashboardController** (`packages/primecare_ui/lib/src/screens/executive/training_director_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
### 📁 Module: `management`
- [ ] **CommunityOutreachDashboardController** (`packages/primecare_ui/lib/src/screens/management/community_outreach_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **ComplianceManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/compliance_manager_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **FranchiseSalesManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/franchise_sales_manager_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **GeneralManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/general_manager_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **GovernanceOfficerDashboardController** (`packages/primecare_ui/lib/src/screens/management/governance_officer_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **HeadOfBusDevDashboardController** (`packages/primecare_ui/lib/src/screens/management/head_of_bus_dev_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **HeadOfMarketingDashboardController** (`packages/primecare_ui/lib/src/screens/management/head_of_marketing_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **LocalMarketingManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/local_marketing_manager_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **OperationsManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/operations_manager_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **PartnershipManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/partnership_manager_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **RegionalBdmDashboardController** (`packages/primecare_ui/lib/src/screens/management/regional_bdm_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **RegionalManagerUsaDashboardController** (`packages/primecare_ui/lib/src/screens/management/regional_manager_usa_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **ScrumMasterDashboardController** (`packages/primecare_ui/lib/src/screens/management/scrum_master_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **TerritoryExpansionManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/territory_expansion_manager_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **TerritorySalesManagerDashboardController** (`packages/primecare_ui/lib/src/screens/management/territory_sales_manager_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
### 📁 Module: `psw`
- [ ] **PswDashboardController** (`packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
### 📁 Module: `rn`
- [ ] **RnDashboardController** (`packages/primecare_ui/lib/src/screens/rn/rn_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
### 📁 Module: `rpn`
- [ ] **RpnDashboardController** (`packages/primecare_ui/lib/src/screens/rpn/rpn_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
### 📁 Module: `staff`
- [ ] **BillingAdminDashboardController** (`packages/primecare_ui/lib/src/screens/staff/billing_admin_dashboard_screen.dart`):
  - [ ] Wire `Threshold Capacity Adjuster` (`ID: capacity_slider`) to active API/controller method instead of mock: `onChanged: (val) { controller.updateThreshold(...) }`
- [ ] **HrHiringDashboardController** (`packages/primecare_ui/lib/src/screens/staff/hr_hiring_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **HrManagerDashboardController** (`packages/primecare_ui/lib/src/screens/staff/hr_manager_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **IntakeCoordinatorDashboardController** (`packages/primecare_ui/lib/src/screens/staff/intake_coordinator_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **QualityAssuranceDashboardController** (`packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **ReceptionistDashboardController** (`packages/primecare_ui/lib/src/screens/staff/receptionist_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **SchedulerDashboardController** (`packages/primecare_ui/lib/src/screens/staff/scheduler_dashboard_screen.dart`):
  - [ ] Wire `Threshold Capacity Adjuster` (`ID: capacity_slider`) to active API/controller method instead of mock: `onChanged: (val) { controller.updateThreshold(...) }`
- [ ] **TrainingCoordinatorDashboardController** (`packages/primecare_ui/lib/src/screens/staff/training_coordinator_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`
- [ ] **VolunteerCoordinatorDashboardController** (`packages/primecare_ui/lib/src/screens/staff/volunteer_coordinator_dashboard_screen.dart`):
  - [ ] Wire `Export Logs` (`ID: export_logs`) to active API/controller method instead of mock: `() => controller.exportLogs()`
  - [ ] Wire `Live Auditing timeline Console` (`ID: audit_logs_terminal`) to active API/controller method instead of mock: `state.logs`
  - [ ] Wire `Policy Update` (`ID: policy_update`) to active API/controller method instead of mock: `() => controller.updatePolicy()`
  - [ ] Wire `Run Audit Scan` (`ID: run_audit_scan`) to active API/controller method instead of mock: `state.isLoading ? () {} : () => controller.runComplianceScan()`
  - [ ] Wire `Sync Posture` (`ID: sync_posture`) to active API/controller method instead of mock: `() => controller.syncPosture()`

## 📋 Full Master Sidebar Item Catalog

| Screen | Sidebar Item | Callback / Action Callback | Integration Status | Connected to API |
|--------|--------------|----------------------------|--------------------|------------------|
| `ArchitecturePlanningDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `ArchitecturePlanningDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `ArchitecturePlanningDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `ArchitecturePlanningDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `ArchitecturePlanningDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `BillingAdminDashboardController` | `Threshold Capacity Adjuster` | `onChanged: (val) { controller.updateThreshold(....` | `mock_stub` | 🔴 Mock/Stub |
| `BusinessDevelopmentDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `BusinessDevelopmentDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `BusinessDevelopmentDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `BusinessDevelopmentDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `BusinessDevelopmentDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `CfoDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `CfoDashboardController` | `Threshold Capacity Adjuster` | `onChanged: (val) { controller.updateThreshold(....` | `mock_stub` | 🔴 Mock/Stub |
| `ChiropractorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `ChiropractorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `ChiropractorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `ChiropractorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `ChiropractorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `CisoDashboardController` | `Clear Log Consoles` | `() => controller.clearLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `CisoDashboardController` | `Sync Posture` | `state.isLoading ? () {} : () => controller.sync...` | `mock_stub` | 🔴 Mock/Stub |
| `CisoDashboardController` | `Threshold Capacity Adjuster` | `onChanged: (val) { controller.updateThreshold(....` | `mock_stub` | 🔴 Mock/Stub |
| `ClinicDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `ClinicDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `ClinicDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `ClinicDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `ClinicDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `ClinicalDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `ClinicalDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `ClinicalDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `ClinicalDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `ClinicalDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `CommunityOutreachDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `CommunityOutreachDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `CommunityOutreachDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `CommunityOutreachDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `CommunityOutreachDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `ComplianceManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `ComplianceManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `ComplianceManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `ComplianceManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `ComplianceManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `CooDashboardNotifier` | `Live Auditing timeline Console` | `state.logs` | `api_connected` | 🟢 Connected |
| `CooDashboardNotifier` | `Run Audit Scan` | `() => ref.invalidate(cooDashboardProvider)` | `api_connected` | 🟢 Connected |
| `CourseArchitectDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `CourseArchitectDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `CourseArchitectDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `CourseArchitectDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `CourseArchitectDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `CtoDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `CtoDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `CtoDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `CtoDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `CtoDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `CustomerSupportDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `CustomerSupportDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `CustomerSupportDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `CustomerSupportDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `CustomerSupportDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `CxDirectorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `CxDirectorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `CxDirectorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `CxDirectorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `CxDirectorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `DynamicScreenDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `DynamicScreenDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `DynamicScreenDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `DynamicScreenDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `DynamicScreenDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `FamilyMemberDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `FamilyMemberDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `FamilyMemberDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `FamilyMemberDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `FamilyMemberDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `FinanceDirectorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `FinanceDirectorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `FinanceDirectorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `FinanceDirectorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `FinanceDirectorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `FranchiseDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `FranchiseDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `FranchiseDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `FranchiseDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `FranchiseDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `FranchiseSalesManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `FranchiseSalesManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `FranchiseSalesManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `FranchiseSalesManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `FranchiseSalesManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `GeneralManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `GeneralManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `GeneralManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `GeneralManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `GeneralManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `GovernanceOfficerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `GovernanceOfficerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `GovernanceOfficerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `GovernanceOfficerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `GovernanceOfficerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `GuestDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `GuestDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `GuestDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `GuestDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `GuestDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `HeadOfBusDevDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `HeadOfBusDevDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `HeadOfBusDevDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `HeadOfBusDevDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `HeadOfBusDevDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `HeadOfMarketingDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `HeadOfMarketingDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `HeadOfMarketingDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `HeadOfMarketingDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `HeadOfMarketingDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `HrDirectorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `HrDirectorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `HrDirectorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `HrDirectorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `HrDirectorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `HrHiringDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `HrHiringDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `HrHiringDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `HrHiringDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `HrHiringDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `HrManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `HrManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `HrManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `HrManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `HrManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `InfrastructureDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `InfrastructureDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `InfrastructureDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `InfrastructureDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `InfrastructureDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `IntakeCoordinatorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `IntakeCoordinatorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `IntakeCoordinatorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `IntakeCoordinatorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `IntakeCoordinatorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `IntakeDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `IntakeDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `IntakeDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `IntakeDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `IntakeDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `LegalDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `LegalDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `LegalDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `LegalDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `LegalDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `LocalMarketingManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `LocalMarketingManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `LocalMarketingManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `LocalMarketingManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `LocalMarketingManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `OfficeDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `OfficeDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `OfficeDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `OfficeDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `OfficeDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `OperationsManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `OperationsManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `OperationsManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `OperationsManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `OperationsManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `OwnerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `OwnerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `OwnerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `OwnerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `OwnerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `PartnershipManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `PartnershipManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `PartnershipManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `PartnershipManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `PartnershipManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `PatientDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `PatientDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `PatientDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `PatientDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `PatientDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `PhysiotherapistDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `PhysiotherapistDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `PhysiotherapistDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `PhysiotherapistDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `PhysiotherapistDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `PortalDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `PortalDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `PortalDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `PortalDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `PortalDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `PswDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `PswDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `PswDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `PswDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `PswDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `QaDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `QaDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `QaDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `QaDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `QaDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `ReceptionistDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `ReceptionistDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `ReceptionistDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `ReceptionistDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `ReceptionistDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `RegionalBdmDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `RegionalBdmDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `RegionalBdmDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `RegionalBdmDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `RegionalBdmDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `RegionalManagerUsaDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `RegionalManagerUsaDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `RegionalManagerUsaDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `RegionalManagerUsaDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `RegionalManagerUsaDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `RmtDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `RmtDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `RmtDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `RmtDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `RmtDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `RnDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `RnDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `RnDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `RnDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `RnDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `RpnDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `RpnDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `RpnDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `RpnDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `RpnDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `SchedulerDashboardController` | `Threshold Capacity Adjuster` | `onChanged: (val) { controller.updateThreshold(....` | `mock_stub` | 🔴 Mock/Stub |
| `ScrumMasterDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `ScrumMasterDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `ScrumMasterDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `ScrumMasterDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `ScrumMasterDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `ShareholderDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `ShareholderDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `ShareholderDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `ShareholderDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `ShareholderDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `SocialWorkerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `SocialWorkerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `SocialWorkerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `SocialWorkerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `SocialWorkerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `SupportDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `SupportDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `SupportDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `SupportDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `SupportDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `SystemDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `SystemDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `SystemDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `SystemDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `SystemDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `SystemVerificationDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `SystemVerificationDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `SystemVerificationDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `SystemVerificationDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `SystemVerificationDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `TerritoryExpansionManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `TerritoryExpansionManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `TerritoryExpansionManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `TerritoryExpansionManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `TerritoryExpansionManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `TerritorySalesManagerDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `TerritorySalesManagerDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `TerritorySalesManagerDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `TerritorySalesManagerDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `TerritorySalesManagerDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingCoordinatorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingCoordinatorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingCoordinatorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingCoordinatorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingCoordinatorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingDirectorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingDirectorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingDirectorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingDirectorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingDirectorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingHubDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingHubDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingHubDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingHubDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `TrainingHubDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |
| `VolunteerCoordinatorDashboardController` | `Export Logs` | `() => controller.exportLogs()` | `mock_stub` | 🔴 Mock/Stub |
| `VolunteerCoordinatorDashboardController` | `Live Auditing timeline Console` | `state.logs` | `mock_stub` | 🔴 Mock/Stub |
| `VolunteerCoordinatorDashboardController` | `Policy Update` | `() => controller.updatePolicy()` | `mock_stub` | 🔴 Mock/Stub |
| `VolunteerCoordinatorDashboardController` | `Run Audit Scan` | `state.isLoading ? () {} : () => controller.runC...` | `mock_stub` | 🔴 Mock/Stub |
| `VolunteerCoordinatorDashboardController` | `Sync Posture` | `() => controller.syncPosture()` | `mock_stub` | 🔴 Mock/Stub |