# SCREEN DATA CONTEXT: coo_staffing

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - CooStaffingScreen** screen.

---

## 1. Screen Record
* **ID**: `306`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `coo_staffing`
* **Screen Name**: `CooStaffingScreen`
* **Route Path**: `/executive/coo-staffing`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/coo_staffing_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to coostaffingscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the CooStaffingScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CooStaffingScreen`
* **Acceptance Criteria**:
- The CooStaffingScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_staffing-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_staffing-title` (Type: header, Required: 1)
* **primary_content** -> `coo_staffing-content` (Type: layout, Required: 1)
* **coostaffing_content** -> `coostaffing-content` (Type: layout, Required: 0)
* **coostaffing_btn_1** -> `coostaffing-btn-1` (Type: button, Required: 0)
* **coostaffing_btn_2** -> `coostaffing-btn-2` (Type: button, Required: 0)
* **coostaffing_title** -> `coostaffing-title` (Type: header, Required: 0)
* **coostaffing_loading** -> `coostaffing-loading` (Type: loading, Required: 0)
* **coostaffing_btn_3** -> `coostaffing-btn-3` (Type: button, Required: 0)
* **coostaffing_screen** -> `coostaffing-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `314` (Required: 1)
* Component ID: `848` (Required: 1)
* Component ID: `1382` (Required: 1)
* Component ID: `4325` (Required: 1)
* Component ID: `4326` (Required: 1)
* Component ID: `4327` (Required: 1)
* Component ID: `4328` (Required: 1)
* Component ID: `4329` (Required: 1)
* Component ID: `4330` (Required: 1)
* Component ID: `4331` (Required: 1)
* Component ID: `4332` (Required: 1)
* Component ID: `4333` (Required: 1)
* Component ID: `4334` (Required: 1)

## 7. API / Data Mapping
* API ID: `4635` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_staffing_runtime`
* **Test Name**: `CooStaffingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CooStaffingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/executive/coo-staffing`)
3. **should_be_visible** (Selector: `coo_staffing-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_staffing-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_staffing-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
