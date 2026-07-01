# SCREEN DATA CONTEXT: np_analytics

Below are the database records from `governance.db` used to configure and build the **Nurse Practitioner (NP) - NursePractitionerNPAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `613`
* **App ID**: `1`
* **Role ID**: `54`
* **Screen Code**: `np_analytics`
* **Screen Name**: `NursePractitionerNPAnalyticsScreen`
* **Route Path**: `/rn/np-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/np_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `54`
* **Role Code**: `np`
* **Role Name**: `Nurse Practitioner (NP)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Nurse Practitioner (NP) personnel to oversee, audit, and coordinate operations related to nurse practitioner (np) analytics.`
* **User Story**: `As a Nurse Practitioner (NP), I want to access the Nurse Practitioner (NP) Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Nurse Practitioner (NP) Analytics`
* **Acceptance Criteria**:
- The Nurse Practitioner (NP) Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Nurse Practitioner (NP) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `np_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `np_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `np_analytics-content` (Type: layout, Required: 1)
* **nurse practitioner (np) analytics_btn_1** -> `nurse practitioner (np) analytics-btn-1` (Type: button, Required: 0)
* **nurse practitioner (np) analytics_content** -> `nurse practitioner (np) analytics-content` (Type: layout, Required: 0)
* **nurse practitioner (np) analytics_screen** -> `nurse practitioner (np) analytics-screen` (Type: layout, Required: 0)
* **nurse practitioner (np) analytics_btn_2** -> `nurse practitioner (np) analytics-btn-2` (Type: button, Required: 0)
* **nurse practitioner (np) analytics_title** -> `nurse practitioner (np) analytics-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `537` (Required: 1)
* Component ID: `1071` (Required: 1)
* Component ID: `1605` (Required: 1)
* Component ID: `6350` (Required: 1)
* Component ID: `6351` (Required: 1)
* Component ID: `6352` (Required: 1)
* Component ID: `6353` (Required: 1)
* Component ID: `6354` (Required: 1)
* Component ID: `6355` (Required: 1)
* Component ID: `6356` (Required: 1)
* Component ID: `6357` (Required: 1)
* Component ID: `6358` (Required: 1)
* Component ID: `6359` (Required: 1)

## 7. API / Data Mapping
* API ID: `4966` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `np_analytics_runtime`
* **Test Name**: `Nurse Practitioner (NP) Analytics Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Nurse Practitioner N P Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `np`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Nurse Practitioner N P Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Nurse Practitioner N P Analytics`)
5. **check_url** (Selector: `None`, Value: `/rn/np-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
