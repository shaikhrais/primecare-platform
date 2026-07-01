# SCREEN DATA CONTEXT: receptionist_analytics

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - ReceptionistAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `266`
* **App ID**: `1`
* **Role ID**: `59`
* **Screen Code**: `receptionist_analytics`
* **Screen Name**: `ReceptionistAnalyticsScreen`
* **Route Path**: `/staff/receptionist-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/receptionist_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to receptionistanalyticsscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the ReceptionistAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ReceptionistAnalyticsScreen`
* **Acceptance Criteria**:
- The ReceptionistAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `receptionist_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `receptionist_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `receptionist_analytics-content` (Type: layout, Required: 1)
* **receptionistanalytics_screen** -> `receptionistanalytics-screen` (Type: layout, Required: 0)
* **receptionistanalytics_title** -> `receptionistanalytics-title` (Type: header, Required: 0)
* **receptionistanalytics_content** -> `receptionistanalytics-content` (Type: layout, Required: 0)
* **receptionistanalytics_btn_3** -> `receptionistanalytics-btn-3` (Type: button, Required: 0)
* **receptionistanalytics_btn_1** -> `receptionistanalytics-btn-1` (Type: button, Required: 0)
* **receptionistanalytics_btn_2** -> `receptionistanalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `274` (Required: 1)
* Component ID: `808` (Required: 1)
* Component ID: `1342` (Required: 1)
* Component ID: `3970` (Required: 1)
* Component ID: `3971` (Required: 1)
* Component ID: `3972` (Required: 1)
* Component ID: `3973` (Required: 1)
* Component ID: `3974` (Required: 1)
* Component ID: `3975` (Required: 1)
* Component ID: `3976` (Required: 1)
* Component ID: `3977` (Required: 1)
* Component ID: `3978` (Required: 1)
* Component ID: `3979` (Required: 1)

## 7. API / Data Mapping
* API ID: `4587` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `receptionist_analytics_runtime`
* **Test Name**: `ReceptionistAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Receptionist Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Receptionist Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Receptionist Analytics`)
5. **check_url** (Selector: `None`, Value: `/staff/receptionist-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
