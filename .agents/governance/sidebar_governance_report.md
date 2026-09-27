# PrimeCare Sidebar Governance & Quality Dashboard

> [!NOTE]
> This automated dashboard tracks the quality, layout compliance, and backend API integration status for all role-based dashboards in the PrimeCare ecosystem.

This automated governance report compiles split dual-column dashboard structures, verifies active API integrations, and flags pending interface modules.

## 📊 Unified Global Quality & Coverage Metrics

| Dimension | Score | Description |
|-----------|:-----:|-------------|
| **Layout Conformity** | `100.0%` | Code layout matches specifications inside relational SQLite database. |
| **API Connectivity** | `45.5%` | Sidebar items bound to active backend/controller workflows (not mock logs/stubs). |
| **Functional Readiness** | `100.0%` | Total actionable sidebar buttons implemented with non-empty handlers. |

## 📁 Module Directory Quality Breakdowns

| Screen Group | Total Dashboards | Dual-Column | Layout Conformity | API Connectivity | Functional Readiness | Outstanding Fixes |
|--------------|:----------------:|:-----------:|:-----------------:|:----------------:|:--------------------:|:-----------------:|
| **clinical** | 17 | 1 | `100.0%` | `60.0%` | `100.0%` | **2** |
| **common** | 20 | 0 | `100.0%` | `0.0%` | `100.0%` | **1** |
| **executive** | 1 | 0 | `100.0%` | `100.0%` | `100.0%` | **0** |
| **management** | 11 | 0 | `100.0%` | `100.0%` | `100.0%` | **0** |
| **psw** | 1 | 1 | `100.0%` | `100.0%` | `100.0%` | **0** |
| **rn** | 2 | 0 | `100.0%` | `100.0%` | `100.0%` | **0** |
| **rpn** | 1 | 0 | `100.0%` | `100.0%` | `100.0%` | **0** |
| **staff** | 8 | 0 | `100.0%` | `0.0%` | `100.0%` | **2** |

## 👥 Complete Apps & User Roles Directory
Here is the directory of all 55+ user roles within the PrimeCare platform, categorized by their corresponding Screen Groups on disk:

### 📂 `ALLIED` Screen Group
* **Corresponding Roles:** Chiropractor (`chiropractor`), Physiotherapist (`physio`), Registered Massage Therapist (RMT) (`rmt`), Social Worker (`social_worker`), Therapist (`therapist`)
* **Dashboard Count:** 0 physical dashboard screens built.

### 📂 `CLINICAL` Screen Group
* **Corresponding Roles:** Clinical Director (`clinical_director`), Intake Coordinator (`intake`), Registered Nurse (RN) (`rn`), Physician (`physician`), Clinical Nurse Specialist (`cns`), Pediatric Specialist (`pediatric`)
* **Dashboard Count:** 17 physical dashboard screens built.

### 📂 `COMMON` Screen Group
* **Corresponding Roles:** Caregiver (`caregiver`), Guest (`guest`), Portal User (`portal`), Patient (`patient`), Dynamic Screen Viewer (`dynamic`), Infrastructure Auditor (`infrastructure`), System Verification Officer (`system_verification`), Training Candidate (`training`)
* **Dashboard Count:** 20 physical dashboard screens built.

### 📂 `EXECUTIVE` Screen Group
* **Corresponding Roles:** Chief Executive Officer (CEO) (`ceo`), Chief Financial Officer (CFO) (`cfo`), Chief Information Security Officer (CISO) (`ciso`), Chief Operating Officer (COO) (`coo`), Chief Technology Officer (CTO) (`cto`), CX Director (`cx_director`), Finance Director (`finance_director`), HR Director (`hr_director`), Legal Counsel (`legal`), Franchise Owner (`owner`), Shareholder (`shareholder`), Training Director (`training_director`)
* **Dashboard Count:** 1 physical dashboard screens built.

### 📂 `MANAGEMENT` Screen Group
* **Corresponding Roles:** Community Outreach Lead (`community_outreach`), Compliance Manager (`compliance`), Franchise Sales Manager (`franchise_sales`), General Manager (`gm`), Governance Officer (`governance`), Head of Business Development (`bus_dev`), Head of Marketing (`marketing`), Local Marketing Manager (`local_marketing`), Operations Manager (`ops_manager`), Partnership Manager (`partnership`), Regional BDM (`regional_bdm`), Regional Manager USA (`regional_manager_usa`), Scrum Master (`scrum_master`), Talent Acquisition Manager (`hr_hiring`), Territory Expansion Manager (`territory_expansion`), Territory Sales Manager (`territory_sales`), Volunteer Coordinator (`volunteer_coordinator`)
* **Dashboard Count:** 11 physical dashboard screens built.

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
* **Dashboard Count:** 8 physical dashboard screens built.

## 🚨 Anomalies & Architectural Violations
✅ **Zero architectural deviations detected.** Relational SQLite database registry is in perfect alignment with implementation code.

## 🛠️ Master Sidebar Fix Checklist
This actionable checklist lists all mock/stub or pending sidebar items. To resolve an item, edit the screen file, remove the `controller.addLog(...)` call, implement a real controller method call, and run this script to update statistics.

- [ ] **ChiropractorDashboardScreen** (`/offices/clinical/roles/chiropractor/dashboard`):
  - [ ] Wire action handler `onTap_audit_logs_terminal` to active API/controller method instead of mock: `shortcut: state.logs`
- [ ] **IntakeCoordinatorDashboardScreen** (`packages/primecare_ui/lib/src/screens/staff/intake_coordinator_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_audit_logs_terminal` to active API/controller method instead of mock: `shortcut: state.logs`
- [ ] **PhysiotherapistDashboardScreen** (`packages/primecare_ui/lib/src/screens/common/physiotherapist_dashboard_screen.dart`):
  - [ ] Wire action handler `onTap_audit_logs_terminal` to active API/controller method instead of mock: `shortcut: state.logs`
- [ ] **QualityAssuranceDashboardScreen** (`/staff/quality-assurance-dashboard`):
  - [ ] Wire action handler `onTap_audit_logs_terminal` to active API/controller method instead of mock: `shortcut: state.logs`
- [ ] **SocialWorkerDashboardScreen** (`/offices/clinical/roles/social_worker/dashboard`):
  - [ ] Wire action handler `onTap_audit_logs_terminal` to active API/controller method instead of mock: `shortcut: state.logs`
- [ ] **TrainingCoordinatorDashboardScreen** (`/offices/support/roles/training_coordinator/dashboard`):
  - [ ] Wire action handler `onTap_audit_logs_terminal` to active API/controller method instead of mock: `shortcut: state.logs`

## 📋 Full Master Sidebar Item Catalog

| Screen | Callback Name | Callback / Action Callback | Integration Status | Connected to API |
|--------|---------------|----------------------------|--------------------|------------------|
| `ChiropractorDashboardScreen` | `onTap_audit_logs_terminal` | `shortcut: state.logs` | `pending` | 🔴 Mock/Stub |
| `Clinical Director Dashboard` | `onTap_audit_logs_terminal` | `shortcut: state.logs` | `active` | 🟢 Connected |
| `CooDashboardScreen` | `onTap_audit_logs_terminal` | `shortcut: state.logs` | `active` | 🟢 Connected |
| `CooDashboardScreen` | `onTap_run_audit_scan` | `shortcut: () => ref.invalidate(cooDashboardProv...` | `active` | 🟢 Connected |
| `IntakeCoordinatorDashboardScreen` | `onTap_audit_logs_terminal` | `shortcut: state.logs` | `pending` | 🔴 Mock/Stub |
| `PhysicianDashboardScreen` | `onTap_audit_logs_terminal` | `shortcut: state.logs` | `active` | 🟢 Connected |
| `PhysiotherapistDashboardScreen` | `onTap_audit_logs_terminal` | `shortcut: state.logs` | `pending` | 🔴 Mock/Stub |
| `QualityAssuranceDashboardScreen` | `onTap_audit_logs_terminal` | `shortcut: state.logs` | `pending` | 🔴 Mock/Stub |
| `RmtDashboardScreen` | `onTap_audit_logs_terminal` | `shortcut: state.logs` | `active` | 🟢 Connected |
| `SocialWorkerDashboardScreen` | `onTap_audit_logs_terminal` | `shortcut: state.logs` | `pending` | 🔴 Mock/Stub |
| `TrainingCoordinatorDashboardScreen` | `onTap_audit_logs_terminal` | `shortcut: state.logs` | `pending` | 🔴 Mock/Stub |