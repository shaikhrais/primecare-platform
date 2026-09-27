# SCREEN DATA CONTEXT: head_of_bus_dev_dashboard

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - HeadOfBusDevDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `49`
* **App ID**: `4`
* **Role ID**: `37`
* **Screen Code**: `head_of_bus_dev_dashboard`
* **Screen Name**: `HeadOfBusDevDashboardScreen`
* **Route Path**: `/offices/corporate/roles/head_of_bus_dev/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/head_of_bus_dev_dashboard.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `4`
* **App Code**: `bd`
* **App Name**: `Primecare Business Development`

## 3. Role Record
* **ID**: `37`
* **Role Code**: `bus_dev`
* **Role Name**: `Head of Business Development`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Business Development module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to headofbusdevdashboardscreen.`
* **User Story**: `As a Head of Business Development, I want to access the HeadOfBusDevDashboardScreen within the Primecare Business Development application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HeadOfBusDevDashboardScreen`
* **Acceptance Criteria**:
- The HeadOfBusDevDashboardScreen route loads successfully within the Primecare Business Development workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_bus_dev_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_bus_dev_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_bus_dev_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `57` (Required: 1)
* Component ID: `591` (Required: 1)
* Component ID: `1125` (Required: 1)
* Component ID: `2013` (Required: 1)
* Component ID: `2014` (Required: 1)
* Component ID: `2015` (Required: 1)
* Component ID: `2016` (Required: 1)
* Component ID: `2017` (Required: 1)
* Component ID: `2018` (Required: 1)
* Component ID: `2019` (Required: 1)
* Component ID: `2020` (Required: 1)
* Component ID: `2021` (Required: 1)
* Component ID: `2022` (Required: 1)

## 7. API / Data Mapping
* API ID: `4304` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_bus_dev_dashboard_runtime`
* **Test Name**: `HeadOfBusDevDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HeadOfBusDevDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/head_of_bus_dev/dashboard`)
3. **should_be_visible** (Selector: `head_of_bus_dev_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `head_of_bus_dev_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `head_of_bus_dev_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
