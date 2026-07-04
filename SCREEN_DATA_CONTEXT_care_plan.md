# SCREEN DATA CONTEXT: care_plan

Below are the database records from `governance.db` used to configure and build the **Patient - CarePlanScreen** screen.

---

## 1. Screen Record
* **ID**: `570`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `care_plan`
* **Screen Name**: `CarePlanScreen`
* **Route Path**: `/clinic/care-plan`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/care_plan_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `15`
* **Role Code**: `patient`
* **Role Name**: `Patient`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to careplanscreen.`
* **User Story**: `As a Patient, I want to access the CarePlanScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CarePlanScreen`
* **Acceptance Criteria**:
- The CarePlanScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `care_plan-screen` (Type: layout, Required: 1)
* **page_title** -> `care_plan-title` (Type: header, Required: 1)
* **primary_content** -> `care_plan-content` (Type: layout, Required: 1)
* **careplan_btn_2** -> `careplan-btn-2` (Type: button, Required: 0)
* **careplan_btn_3** -> `careplan-btn-3` (Type: button, Required: 0)
* **careplan_screen** -> `careplan-screen` (Type: layout, Required: 0)
* **careplan_loading** -> `careplan-loading` (Type: loading, Required: 0)
* **careplan_title** -> `careplan-title` (Type: header, Required: 0)
* **careplan_btn_1** -> `careplan-btn-1` (Type: button, Required: 0)
* **careplan_content** -> `careplan-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `494` (Required: 1)
* Component ID: `1028` (Required: 1)
* Component ID: `1562` (Required: 1)
* Component ID: `5984` (Required: 1)
* Component ID: `5985` (Required: 1)
* Component ID: `5986` (Required: 1)
* Component ID: `5987` (Required: 1)
* Component ID: `5988` (Required: 1)

## 7. API / Data Mapping
* API ID: `4916` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `care_plan_runtime`
* **Test Name**: `CarePlanScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CarePlanScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **visit** (Selector: `None`, Value: `/clinic/care-plan`)
3. **should_be_visible** (Selector: `care_plan-screen`, Value: `None`)
4. **should_be_visible** (Selector: `care_plan-title`, Value: `None`)
5. **should_be_visible** (Selector: `care_plan-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
