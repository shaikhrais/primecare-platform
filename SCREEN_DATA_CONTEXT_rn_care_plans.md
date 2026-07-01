# SCREEN DATA CONTEXT: rn_care_plans

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnCarePlansScreen** screen.

---

## 1. Screen Record
* **ID**: `241`
* **App ID**: `1`
* **Role ID**: `8`
* **Screen Code**: `rn_care_plans`
* **Screen Name**: `RnCarePlansScreen`
* **Route Path**: `/offices/clinical/roles/rn/rn-care-plans`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_care_plans_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rncareplansscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnCarePlansScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnCarePlansScreen`
* **Acceptance Criteria**:
- The RnCarePlansScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_care_plans-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_care_plans-title` (Type: header, Required: 1)
* **primary_content** -> `rn_care_plans-content` (Type: layout, Required: 1)
* **rncareplans_btn_2** -> `rncareplans-btn-2` (Type: button, Required: 0)
* **rncareplans_btn_1** -> `rncareplans-btn-1` (Type: button, Required: 0)
* **rncareplans_screen** -> `rncareplans-screen` (Type: layout, Required: 0)
* **rn_care_plans_screen_textfield_input_1** -> `rn_care_plans_screen_textfield_input_1` (Type: field, Required: 0)
* **rncareplans_title** -> `rncareplans-title` (Type: header, Required: 0)
* **rncareplans_content** -> `rncareplans-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `249` (Required: 1)
* Component ID: `783` (Required: 1)
* Component ID: `1317` (Required: 1)
* Component ID: `3730` (Required: 1)
* Component ID: `3731` (Required: 1)
* Component ID: `3732` (Required: 1)
* Component ID: `3733` (Required: 1)
* Component ID: `3734` (Required: 1)
* Component ID: `3735` (Required: 1)
* Component ID: `3736` (Required: 1)
* Component ID: `3737` (Required: 1)
* Component ID: `3738` (Required: 1)
* Component ID: `3739` (Required: 1)

## 7. API / Data Mapping
* API ID: `4542` (Required: 1)
* API ID: `4543` (Required: 1)
* API ID: `4544` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_care_plans_runtime`
* **Test Name**: `RnCarePlansScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RN Care Plans`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RN Care Plans`)
4. **click_sidebar_link** (Selector: `None`, Value: `RN Care Plans`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rn/rn-care-plans`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
