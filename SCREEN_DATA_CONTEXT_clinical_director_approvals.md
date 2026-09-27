# SCREEN DATA CONTEXT: clinical_director_approvals

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalDirectorApprovalsScreen** screen.

---

## 1. Screen Record
* **ID**: `302`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `clinical_director_approvals`
* **Screen Name**: `ClinicalDirectorApprovalsScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/approvals`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_approvals_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `6`
* **Role Code**: `clinical_director`
* **Role Name**: `Clinical Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicaldirectorapprovalsscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalDirectorApprovalsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalDirectorApprovalsScreen`
* **Acceptance Criteria**:
- The ClinicalDirectorApprovalsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_director_approvals-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_director_approvals-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_director_approvals-content` (Type: layout, Required: 1)
* **clinicaldirectorapprovals_content** -> `clinicaldirectorapprovals-content` (Type: layout, Required: 0)
* **clinicaldirectorapprovals_screen** -> `clinicaldirectorapprovals-screen` (Type: layout, Required: 0)
* **clinicaldirectorapprovals_btn_2** -> `clinicaldirectorapprovals-btn-2` (Type: button, Required: 0)
* **clinicaldirectorapprovals_btn_1** -> `clinicaldirectorapprovals-btn-1` (Type: button, Required: 0)
* **clinicaldirectorapprovals_btn_3** -> `clinicaldirectorapprovals-btn-3` (Type: button, Required: 0)
* **clinicaldirectorapprovals_title** -> `clinicaldirectorapprovals-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `310` (Required: 1)
* Component ID: `844` (Required: 1)
* Component ID: `1378` (Required: 1)
* Component ID: `4289` (Required: 1)
* Component ID: `4290` (Required: 1)
* Component ID: `4291` (Required: 1)
* Component ID: `4292` (Required: 1)
* Component ID: `4293` (Required: 1)
* Component ID: `4294` (Required: 1)
* Component ID: `4295` (Required: 1)
* Component ID: `4296` (Required: 1)

## 7. API / Data Mapping
* API ID: `4629` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_director_approvals_runtime`
* **Test Name**: `ClinicalDirectorApprovalsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClinicalDirectorApprovalsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/approvals`)
3. **should_be_visible** (Selector: `clinical_director_approvals-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_director_approvals-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_director_approvals-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
