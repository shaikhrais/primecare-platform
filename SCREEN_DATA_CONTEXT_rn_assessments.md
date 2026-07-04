# SCREEN DATA CONTEXT: rn_assessments

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnAssessmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `240`
* **App ID**: `1`
* **Role ID**: `8`
* **Screen Code**: `rn_assessments`
* **Screen Name**: `RnAssessmentsScreen`
* **Route Path**: `/offices/clinical/roles/rn/rn-assessments`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_assessments_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `8`
* **Role Code**: `rn`
* **Role Name**: `Registered Nurse (RN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rnassessmentsscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnAssessmentsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnAssessmentsScreen`
* **Acceptance Criteria**:
- The RnAssessmentsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_assessments-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_assessments-title` (Type: header, Required: 1)
* **primary_content** -> `rn_assessments-content` (Type: layout, Required: 1)
* **rnassessments_screen** -> `rnassessments-screen` (Type: layout, Required: 0)
* **rnassessments_content** -> `rnassessments-content` (Type: layout, Required: 0)
* **rnassessments_loading** -> `rnassessments-loading` (Type: loading, Required: 0)
* **rnassessments_btn_1** -> `rnassessments-btn-1` (Type: button, Required: 0)
* **rnassessments_btn_2** -> `rnassessments-btn-2` (Type: button, Required: 0)
* **rnassessments_title_appbar** -> `rnassessments-title-appbar` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `248` (Required: 1)
* Component ID: `782` (Required: 1)
* Component ID: `1316` (Required: 1)
* Component ID: `3722` (Required: 1)
* Component ID: `3723` (Required: 1)
* Component ID: `3724` (Required: 1)
* Component ID: `3725` (Required: 1)
* Component ID: `3726` (Required: 1)
* Component ID: `3727` (Required: 1)
* Component ID: `3728` (Required: 1)
* Component ID: `3729` (Required: 1)

## 7. API / Data Mapping
* API ID: `4539` (Required: 1)
* API ID: `4540` (Required: 1)
* API ID: `4541` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_assessments_runtime`
* **Test Name**: `RnAssessmentsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RnAssessmentsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rn/rn-assessments`)
3. **should_be_visible** (Selector: `rn_assessments-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_assessments-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_assessments-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
