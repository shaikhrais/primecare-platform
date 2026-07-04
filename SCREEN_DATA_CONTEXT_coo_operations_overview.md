# SCREEN DATA CONTEXT: coo_operations_overview

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - CooOperationsOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `305`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `coo_operations_overview`
* **Screen Name**: `CooOperationsOverviewScreen`
* **Route Path**: `/offices/corporate/roles/coo/operations-overview`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/coo_operations_overview_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to coooperationsoverviewscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the CooOperationsOverviewScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CooOperationsOverviewScreen`
* **Acceptance Criteria**:
- The CooOperationsOverviewScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_operations_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_operations_overview-title` (Type: header, Required: 1)
* **primary_content** -> `coo_operations_overview-content` (Type: layout, Required: 1)
* **coooperationsoverview_title** -> `coooperationsoverview-title` (Type: header, Required: 0)
* **coooperationsoverview_btn_3** -> `coooperationsoverview-btn-3` (Type: button, Required: 0)
* **coooperationsoverview_btn_1** -> `coooperationsoverview-btn-1` (Type: button, Required: 0)
* **coooperationsoverview_btn_2** -> `coooperationsoverview-btn-2` (Type: button, Required: 0)
* **coooperationsoverview_screen** -> `coooperationsoverview-screen` (Type: layout, Required: 0)
* **coooperationsoverview_content** -> `coooperationsoverview-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `313` (Required: 1)
* Component ID: `847` (Required: 1)
* Component ID: `1381` (Required: 1)
* Component ID: `4315` (Required: 1)
* Component ID: `4316` (Required: 1)
* Component ID: `4317` (Required: 1)
* Component ID: `4318` (Required: 1)
* Component ID: `4319` (Required: 1)
* Component ID: `4320` (Required: 1)
* Component ID: `4321` (Required: 1)
* Component ID: `4322` (Required: 1)
* Component ID: `4323` (Required: 1)
* Component ID: `4324` (Required: 1)

## 7. API / Data Mapping
* API ID: `4634` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_operations_overview_runtime`
* **Test Name**: `CooOperationsOverviewScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CooOperationsOverviewScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/coo/operations-overview`)
3. **should_be_visible** (Selector: `coo_operations_overview-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_operations_overview-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_operations_overview-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
