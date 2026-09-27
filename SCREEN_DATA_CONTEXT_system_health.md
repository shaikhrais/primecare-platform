# SCREEN DATA CONTEXT: system_health

Below are the database records from `governance.db` used to configure and build the **Chief Technology Officer (CTO) - SystemHealthScreen** screen.

---

## 1. Screen Record
* **ID**: `480`
* **App ID**: `7`
* **Role ID**: `24`
* **Screen Code**: `system_health`
* **Screen Name**: `SystemHealthScreen`
* **Route Path**: `/executive/system-health`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/system_health_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `24`
* **Role Code**: `cto`
* **Role Name**: `Chief Technology Officer (CTO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Technology Officer (CTO) personnel to oversee, audit, and coordinate operations related to systemhealthscreen.`
* **User Story**: `As a Chief Technology Officer (CTO), I want to access the SystemHealthScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SystemHealthScreen`
* **Acceptance Criteria**:
- The SystemHealthScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Technology Officer (CTO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `system_health-screen` (Type: layout, Required: 1)
* **page_title** -> `system_health-title` (Type: header, Required: 1)
* **primary_content** -> `system_health-content` (Type: layout, Required: 1)
* **systemhealth_title** -> `systemhealth-title` (Type: header, Required: 0)
* **systemhealth_btn_2** -> `systemhealth-btn-2` (Type: button, Required: 0)
* **systemhealth_btn_1** -> `systemhealth-btn-1` (Type: button, Required: 0)
* **systemhealth_btn_3** -> `systemhealth-btn-3` (Type: button, Required: 0)
* **systemhealth_content** -> `systemhealth-content` (Type: layout, Required: 0)
* **systemhealth_screen** -> `systemhealth-screen` (Type: layout, Required: 0)
* **systemhealth_loading** -> `systemhealth-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `409` (Required: 1)
* Component ID: `943` (Required: 1)
* Component ID: `1477` (Required: 1)
* Component ID: `5184` (Required: 1)
* Component ID: `5185` (Required: 1)
* Component ID: `5186` (Required: 1)
* Component ID: `5187` (Required: 1)
* Component ID: `5188` (Required: 1)
* Component ID: `5189` (Required: 1)
* Component ID: `5190` (Required: 1)
* Component ID: `5191` (Required: 1)
* Component ID: `5192` (Required: 1)
* Component ID: `5193` (Required: 1)

## 7. API / Data Mapping
* API ID: `4797` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `system_health_runtime`
* **Test Name**: `SystemHealthScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SystemHealthScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cto`)
2. **visit** (Selector: `None`, Value: `/executive/system-health`)
3. **should_be_visible** (Selector: `system_health-screen`, Value: `None`)
4. **should_be_visible** (Selector: `system_health-title`, Value: `None`)
5. **should_be_visible** (Selector: `system_health-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
