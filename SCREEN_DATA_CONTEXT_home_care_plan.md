# SCREEN DATA CONTEXT: home_care_plan

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - HomeCarePlanScreen** screen.

---

## 1. Screen Record
* **ID**: `543`
* **App ID**: `5`
* **Role ID**: `3`
* **Screen Code**: `home_care_plan`
* **Screen Name**: `HomeCarePlanScreen`
* **Route Path**: `/offices/clinical/roles/rmt/home-care-plan`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/home_care_plan_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to homecareplanscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the HomeCarePlanScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HomeCarePlanScreen`
* **Acceptance Criteria**:
- The HomeCarePlanScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `home_care_plan-screen` (Type: layout, Required: 1)
* **page_title** -> `home_care_plan-title` (Type: header, Required: 1)
* **primary_content** -> `home_care_plan-content` (Type: layout, Required: 1)
* **homecareplan_title** -> `homecareplan-title` (Type: header, Required: 0)
* **homecareplan_btn_3** -> `homecareplan-btn-3` (Type: button, Required: 0)
* **homecareplan_screen** -> `homecareplan-screen` (Type: layout, Required: 0)
* **homecareplan_content** -> `homecareplan-content` (Type: layout, Required: 0)
* **homecareplan_loading** -> `homecareplan-loading` (Type: loading, Required: 0)
* **homecareplan_btn_2** -> `homecareplan-btn-2` (Type: button, Required: 0)
* **homecareplan_btn_1** -> `homecareplan-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `467` (Required: 1)
* Component ID: `1001` (Required: 1)
* Component ID: `1535` (Required: 1)
* Component ID: `5747` (Required: 1)
* Component ID: `5748` (Required: 1)
* Component ID: `5749` (Required: 1)
* Component ID: `5750` (Required: 1)
* Component ID: `5751` (Required: 1)
* Component ID: `5752` (Required: 1)
* Component ID: `5753` (Required: 1)
* Component ID: `5754` (Required: 1)
* Component ID: `5755` (Required: 1)
* Component ID: `5756` (Required: 1)

## 7. API / Data Mapping
* API ID: `4874` (Required: 1)
* API ID: `4875` (Required: 1)
* API ID: `4876` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `home_care_plan_runtime`
* **Test Name**: `HomeCarePlanScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Home Care Plan`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Home Care Plan`)
4. **click_sidebar_link** (Selector: `None`, Value: `Home Care Plan`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/home-care-plan`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
