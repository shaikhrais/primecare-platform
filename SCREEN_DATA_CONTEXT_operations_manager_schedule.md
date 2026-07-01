# SCREEN DATA CONTEXT: operations_manager_schedule

Below are the database records from `governance.db` used to configure and build the **Guest - OperationsManagerScheduleScreen** screen.

---

## 1. Screen Record
* **ID**: `805`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `operations_manager_schedule`
* **Screen Name**: `OperationsManagerScheduleScreen`
* **Route Path**: `/offices/franchise/roles/operations_manager/schedule`
* **Actual File Path**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_schedule_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to operations manager schedule.`
* **User Story**: `As a Guest, I want to access the Operations Manager Schedule within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Operations Manager Schedule`
* **Acceptance Criteria**:
- The Operations Manager Schedule route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `operations_manager_schedule-screen` (Type: layout, Required: 1)
* **page_title** -> `operations_manager_schedule-title` (Type: header, Required: 1)
* **primary_content** -> `operations_manager_schedule-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7409` (Required: 1)
* Component ID: `7410` (Required: 1)
* Component ID: `7411` (Required: 1)
* Component ID: `7412` (Required: 1)
* Component ID: `7413` (Required: 1)
* Component ID: `7414` (Required: 1)

## 7. API / Data Mapping
* API ID: `5193` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `operations_manager_schedule_runtime`
* **Test Name**: `Operations Manager Schedule Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Operations Manager Schedule`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Operations Manager Schedule`)
4. **click_sidebar_link** (Selector: `None`, Value: `Operations Manager Schedule`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/operations_manager/schedule`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
