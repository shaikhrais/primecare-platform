# SCREEN DATA CONTEXT: hr_director_compliance

Below are the database records from `governance.db` used to configure and build the **HR Director - HrDirectorComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `172`
* **App ID**: `1`
* **Role ID**: `27`
* **Screen Code**: `hr_director_compliance`
* **Screen Name**: `HrDirectorComplianceScreen`
* **Route Path**: `/executive/hr-director-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/hr_director_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrdirectorcompliancescreen.`
* **User Story**: `As a HR Director, I want to access the HrDirectorComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrDirectorComplianceScreen`
* **Acceptance Criteria**:
- The HrDirectorComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_director_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_director_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `hr_director_compliance-content` (Type: layout, Required: 1)
* **hrdirectorcompliance_screen** -> `hrdirectorcompliance-screen` (Type: layout, Required: 0)
* **hrdirectorcompliance_title** -> `hrdirectorcompliance-title` (Type: header, Required: 0)
* **hrdirectorcompliance_btn_1** -> `hrdirectorcompliance-btn-1` (Type: button, Required: 0)
* **hrdirectorcompliance_btn_3** -> `hrdirectorcompliance-btn-3` (Type: button, Required: 0)
* **hrdirectorcompliance_content** -> `hrdirectorcompliance-content` (Type: layout, Required: 0)
* **hrdirectorcompliance_btn_2** -> `hrdirectorcompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `180` (Required: 1)
* Component ID: `714` (Required: 1)
* Component ID: `1248` (Required: 1)
* Component ID: `3100` (Required: 1)
* Component ID: `3101` (Required: 1)
* Component ID: `3102` (Required: 1)
* Component ID: `3103` (Required: 1)
* Component ID: `3104` (Required: 1)
* Component ID: `3105` (Required: 1)
* Component ID: `3106` (Required: 1)
* Component ID: `3107` (Required: 1)
* Component ID: `3108` (Required: 1)
* Component ID: `3109` (Required: 1)

## 7. API / Data Mapping
* API ID: `4461` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_director_compliance_runtime`
* **Test Name**: `HrDirectorComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrDirectorComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **visit** (Selector: `None`, Value: `/executive/hr-director-compliance`)
3. **should_be_visible** (Selector: `hr_director_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_director_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_director_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
