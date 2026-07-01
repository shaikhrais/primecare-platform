# SCREEN DATA CONTEXT: daily_operations

Below are the database records from `governance.db` used to configure and build the **Operations Manager - DailyOperationsScreen** screen.

---

## 1. Screen Record
* **ID**: `508`
* **App ID**: `5`
* **Role ID**: `40`
* **Screen Code**: `daily_operations`
* **Screen Name**: `DailyOperationsScreen`
* **Route Path**: `/management/daily-operations`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/daily_operations_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `40`
* **Role Code**: `ops_manager`
* **Role Name**: `Operations Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Operations Manager personnel to oversee, audit, and coordinate operations related to dailyoperationsscreen.`
* **User Story**: `As a Operations Manager, I want to access the DailyOperationsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `DailyOperationsScreen`
* **Acceptance Criteria**:
- The DailyOperationsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Operations Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `daily_operations-screen` (Type: layout, Required: 1)
* **page_title** -> `daily_operations-title` (Type: header, Required: 1)
* **primary_content** -> `daily_operations-content` (Type: layout, Required: 1)
* **dailyoperations_btn_3** -> `dailyoperations-btn-3` (Type: button, Required: 0)
* **dailyoperations_btn_2** -> `dailyoperations-btn-2` (Type: button, Required: 0)
* **dailyoperations_screen** -> `dailyoperations-screen` (Type: layout, Required: 0)
* **dailyoperations_loading** -> `dailyoperations-loading` (Type: loading, Required: 0)
* **dailyoperations_title** -> `dailyoperations-title` (Type: header, Required: 0)
* **dailyoperations_btn_1** -> `dailyoperations-btn-1` (Type: button, Required: 0)
* **dailyoperations_content** -> `dailyoperations-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `437` (Required: 1)
* Component ID: `971` (Required: 1)
* Component ID: `1505` (Required: 1)
* Component ID: `5459` (Required: 1)
* Component ID: `5460` (Required: 1)
* Component ID: `5461` (Required: 1)
* Component ID: `5462` (Required: 1)
* Component ID: `5463` (Required: 1)
* Component ID: `5464` (Required: 1)
* Component ID: `5465` (Required: 1)
* Component ID: `5466` (Required: 1)
* Component ID: `5467` (Required: 1)
* Component ID: `5468` (Required: 1)

## 7. API / Data Mapping
* API ID: `4824` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `daily_operations_runtime`
* **Test Name**: `DailyOperationsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Daily Operations`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ops_manager`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Daily Operations`)
4. **click_sidebar_link** (Selector: `None`, Value: `Daily Operations`)
5. **check_url** (Selector: `None`, Value: `/management/daily-operations`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
