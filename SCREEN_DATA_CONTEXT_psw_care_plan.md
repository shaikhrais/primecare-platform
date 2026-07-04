# SCREEN DATA CONTEXT: psw_care_plan

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - PswCarePlanScreen** screen.

---

## 1. Screen Record
* **ID**: `349`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `psw_care_plan`
* **Screen Name**: `PswCarePlanScreen`
* **Route Path**: `/offices/clinical/roles/psw/care-plan`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_care_plan_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswcareplanscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswCarePlanScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswCarePlanScreen`
* **Acceptance Criteria**:
- The PswCarePlanScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_care_plan-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_care_plan-title` (Type: header, Required: 1)
* **primary_content** -> `psw_care_plan-content` (Type: layout, Required: 1)
* **pswcareplan_screen** -> `pswcareplan-screen` (Type: layout, Required: 0)
* **pswcareplan_btn_1** -> `pswcareplan-btn-1` (Type: button, Required: 0)
* **pswcareplan_title** -> `pswcareplan-title` (Type: header, Required: 0)
* **pswcareplan_btn_2** -> `pswcareplan-btn-2` (Type: button, Required: 0)
* **pswcareplan_content** -> `pswcareplan-content` (Type: layout, Required: 0)
* **pswcareplan_btn_3** -> `pswcareplan-btn-3` (Type: button, Required: 0)
* **pswcareplan_loading** -> `pswcareplan-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `356` (Required: 1)
* Component ID: `890` (Required: 1)
* Component ID: `1424` (Required: 1)
* Component ID: `4678` (Required: 1)
* Component ID: `4679` (Required: 1)
* Component ID: `4680` (Required: 1)
* Component ID: `4681` (Required: 1)
* Component ID: `4682` (Required: 1)
* Component ID: `4683` (Required: 1)
* Component ID: `4684` (Required: 1)

## 7. API / Data Mapping
* API ID: `4681` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_care_plan_runtime`
* **Test Name**: `Psw Care Plan Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Care Plan`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/care-plan`)
3. **should_be_visible** (Selector: `psw_care_plan-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_care_plan-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_care_plan-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
