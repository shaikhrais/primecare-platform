# SCREEN DATA CONTEXT: data_privacy_monitor

Below are the database records from `governance.db` used to configure and build the **Guest - DataPrivacyMonitorScreen** screen.

---

## 1. Screen Record
* **ID**: `909`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `data_privacy_monitor`
* **Screen Name**: `DataPrivacyMonitorScreen`
* **Route Path**: `/generated/data-privacy-monitor`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/data_privacy_monitor.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to data privacy monitor.`
* **User Story**: `As a Guest, I want to access the Data Privacy Monitor within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Data Privacy Monitor`
* **Acceptance Criteria**:
- The Data Privacy Monitor route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `data_privacy_monitor-screen` (Type: layout, Required: 1)
* **page_title** -> `data_privacy_monitor-title` (Type: header, Required: 1)
* **primary_content** -> `data_privacy_monitor-content` (Type: layout, Required: 1)
* **data_privacy_monitor_iconbutton_button_1** -> `data_privacy_monitor_iconbutton_button_1` (Type: button, Required: 0)
* **data_privacy_monitor_outlinedbutton_button_1** -> `data_privacy_monitor_outlinedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7999` (Required: 1)
* Component ID: `8000` (Required: 1)
* Component ID: `8001` (Required: 1)
* Component ID: `8002` (Required: 1)
* Component ID: `8003` (Required: 1)

## 7. API / Data Mapping
* API ID: `5329` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `data_privacy_monitor_runtime`
* **Test Name**: `Data Privacy Monitor Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Data Privacy Monitor`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Data Privacy Monitor`)
4. **click_sidebar_link** (Selector: `None`, Value: `Data Privacy Monitor`)
5. **check_url** (Selector: `None`, Value: `/generated/data-privacy-monitor`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
