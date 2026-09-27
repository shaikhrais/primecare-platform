# SCREEN DATA CONTEXT: system_capacity_planner

Below are the database records from `governance.db` used to configure and build the **Guest - SystemCapacityPlannerScreen** screen.

---

## 1. Screen Record
* **ID**: `932`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `system_capacity_planner`
* **Screen Name**: `SystemCapacityPlannerScreen`
* **Route Path**: `/generated/system-capacity-planner`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/system_capacity_planner.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to system capacity planner.`
* **User Story**: `As a Guest, I want to access the System Capacity Planner within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `System Capacity Planner`
* **Acceptance Criteria**:
- The System Capacity Planner route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `system_capacity_planner-screen` (Type: layout, Required: 1)
* **page_title** -> `system_capacity_planner-title` (Type: header, Required: 1)
* **primary_content** -> `system_capacity_planner-content` (Type: layout, Required: 1)
* **system_capacity_planner_iconbutton_button_1** -> `system_capacity_planner_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8111` (Required: 1)
* Component ID: `8112` (Required: 1)
* Component ID: `8113` (Required: 1)

## 7. API / Data Mapping
* API ID: `5364` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `system_capacity_planner_runtime`
* **Test Name**: `System Capacity Planner Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `System Capacity Planner`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/system-capacity-planner`)
3. **should_be_visible** (Selector: `system_capacity_planner-screen`, Value: `None`)
4. **should_be_visible** (Selector: `system_capacity_planner-title`, Value: `None`)
5. **should_be_visible** (Selector: `system_capacity_planner-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
