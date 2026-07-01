# SCREEN DATA CONTEXT: hsw_care_plans

Below are the database records from `governance.db` used to configure and build the **Home Support Worker - HswCarePlansScreen** screen.

---

## 1. Screen Record
* **ID**: `83`
* **App ID**: `1`
* **Role ID**: `52`
* **Screen Code**: `hsw_care_plans`
* **Screen Name**: `HswCarePlansScreen`
* **Route Path**: `/clinical/hsw-care-plans`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/hsw_care_plans_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `52`
* **Role Code**: `hsw`
* **Role Name**: `Home Support Worker`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Home Support Worker personnel to oversee, audit, and coordinate operations related to hswcareplansscreen.`
* **User Story**: `As a Home Support Worker, I want to access the HswCarePlansScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HswCarePlansScreen`
* **Acceptance Criteria**:
- The HswCarePlansScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Home Support Worker access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hsw_care_plans-screen` (Type: layout, Required: 1)
* **page_title** -> `hsw_care_plans-title` (Type: header, Required: 1)
* **primary_content** -> `hsw_care_plans-content` (Type: layout, Required: 1)
* **hswcareplans_content** -> `hswcareplans-content` (Type: layout, Required: 0)
* **sign_off_care_plan_review** -> `sign_off_care_plan_review` (Type: custom, Required: 0)
* **data_cy_hsw_mobility_aids_panel** -> `data-cy-hsw-mobility-aids-panel` (Type: custom, Required: 0)
* **hswcareplans_screen** -> `hswcareplans-screen` (Type: layout, Required: 0)
* **hswcareplans_btn_1** -> `hswcareplans-btn-1` (Type: button, Required: 0)
* **hswcareplans_title** -> `hswcareplans-title` (Type: header, Required: 0)
* **data_cy_hsw_dietary_guidelines_viewer** -> `data-cy-hsw-dietary-guidelines-viewer` (Type: custom, Required: 0)

## 6. Component Mapping
* Component ID: `91` (Required: 1)
* Component ID: `625` (Required: 1)
* Component ID: `1159` (Required: 1)
* Component ID: `2320` (Required: 1)
* Component ID: `2321` (Required: 1)
* Component ID: `2322` (Required: 1)
* Component ID: `2323` (Required: 1)
* Component ID: `2324` (Required: 1)
* Component ID: `2325` (Required: 1)
* Component ID: `2326` (Required: 1)
* Component ID: `2327` (Required: 1)
* Component ID: `2328` (Required: 1)
* Component ID: `2329` (Required: 1)

## 7. API / Data Mapping
* API ID: `4356` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hsw_care_plans_runtime`
* **Test Name**: `HswCarePlansScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HSW Care Plans`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hsw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HSW Care Plans`)
4. **click_sidebar_link** (Selector: `None`, Value: `HSW Care Plans`)
5. **check_url** (Selector: `None`, Value: `/clinical/hsw-care-plans`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
