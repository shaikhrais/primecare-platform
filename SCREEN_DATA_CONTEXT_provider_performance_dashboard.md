# SCREEN DATA CONTEXT: provider_performance_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - ProviderPerformanceDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `921`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `provider_performance_dashboard`
* **Screen Name**: `ProviderPerformanceDashboardScreen`
* **Route Path**: `/generated/provider-performance-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/provider_performance_dashboard.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to provider performance dashboard.`
* **User Story**: `As a Guest, I want to access the Provider Performance Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Provider Performance Dashboard`
* **Acceptance Criteria**:
- The Provider Performance Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `provider_performance_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `provider_performance_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `provider_performance_dashboard-content` (Type: layout, Required: 1)
* **provider_performance_dashboard_iconbutton_button_1** -> `provider_performance_dashboard_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8052` (Required: 1)
* Component ID: `8053` (Required: 1)
* Component ID: `8054` (Required: 1)
* Component ID: `8055` (Required: 1)
* Component ID: `8056` (Required: 1)

## 7. API / Data Mapping
* API ID: `5343` (Required: 1)
* API ID: `5344` (Required: 1)
* API ID: `5345` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `provider_performance_dashboard_runtime`
* **Test Name**: `Provider Performance Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Provider Performance Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/provider-performance-dashboard`)
3. **should_be_visible** (Selector: `provider_performance_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `provider_performance_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `provider_performance_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
