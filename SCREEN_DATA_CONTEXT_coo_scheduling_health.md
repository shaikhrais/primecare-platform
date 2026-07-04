# SCREEN DATA CONTEXT: coo_scheduling_health

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - CooSchedulingHealthScreen** screen.

---

## 1. Screen Record
* **ID**: `307`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `coo_scheduling_health`
* **Screen Name**: `CooSchedulingHealthScreen`
* **Route Path**: `/offices/corporate/roles/coo/scheduling-health`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/coo_scheduling_health_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `23`
* **Role Code**: `coo`
* **Role Name**: `Chief Operating Officer (COO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to cooschedulinghealthscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the CooSchedulingHealthScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CooSchedulingHealthScreen`
* **Acceptance Criteria**:
- The CooSchedulingHealthScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_scheduling_health-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_scheduling_health-title` (Type: header, Required: 1)
* **primary_content** -> `coo_scheduling_health-content` (Type: layout, Required: 1)
* **cooschedulinghealth_screen** -> `cooschedulinghealth-screen` (Type: layout, Required: 0)
* **cooschedulinghealth_title** -> `cooschedulinghealth-title` (Type: header, Required: 0)
* **cooschedulinghealth_btn_1** -> `cooschedulinghealth-btn-1` (Type: button, Required: 0)
* **cooschedulinghealth_content** -> `cooschedulinghealth-content` (Type: layout, Required: 0)
* **cooschedulinghealth_btn_2** -> `cooschedulinghealth-btn-2` (Type: button, Required: 0)
* **cooschedulinghealth_btn_3** -> `cooschedulinghealth-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `315` (Required: 1)
* Component ID: `849` (Required: 1)
* Component ID: `1383` (Required: 1)
* Component ID: `4335` (Required: 1)
* Component ID: `4336` (Required: 1)
* Component ID: `4337` (Required: 1)
* Component ID: `4338` (Required: 1)
* Component ID: `4339` (Required: 1)
* Component ID: `4340` (Required: 1)
* Component ID: `4341` (Required: 1)
* Component ID: `4342` (Required: 1)
* Component ID: `4343` (Required: 1)
* Component ID: `4344` (Required: 1)

## 7. API / Data Mapping
* API ID: `4636` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_scheduling_health_runtime`
* **Test Name**: `CooSchedulingHealthScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CooSchedulingHealthScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/coo/scheduling-health`)
3. **should_be_visible** (Selector: `coo_scheduling_health-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_scheduling_health-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_scheduling_health-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
