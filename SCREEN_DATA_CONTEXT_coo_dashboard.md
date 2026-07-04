# SCREEN DATA CONTEXT: coo_dashboard

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - CooDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `35`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `coo_dashboard`
* **Screen Name**: `CooDashboardScreen`
* **Route Path**: `/offices/corporate/roles/coo/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/coo_dashboard.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to coodashboardscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the CooDashboardScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CooDashboardScreen`
* **Acceptance Criteria**:
- The CooDashboardScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `coo_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `43` (Required: 1)
* Component ID: `577` (Required: 1)
* Component ID: `1111` (Required: 1)
* Component ID: `1884` (Required: 1)
* Component ID: `1885` (Required: 1)
* Component ID: `1886` (Required: 1)
* Component ID: `1887` (Required: 1)
* Component ID: `1888` (Required: 1)
* Component ID: `1889` (Required: 1)
* Component ID: `1890` (Required: 1)
* Component ID: `1891` (Required: 1)
* Component ID: `1892` (Required: 1)
* Component ID: `1893` (Required: 1)

## 7. API / Data Mapping
* API ID: `4290` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_dashboard_runtime`
* **Test Name**: `CooDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CooDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/coo/dashboard`)
3. **should_be_visible** (Selector: `coo_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
