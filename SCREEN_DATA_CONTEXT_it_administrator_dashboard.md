# SCREEN DATA CONTEXT: it_administrator_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - ItAdministratorDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `897`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `it_administrator_dashboard`
* **Screen Name**: `ItAdministratorDashboardScreen`
* **Route Path**: `/generated/it-administrator-dashboard`
* **Actual File Path**: `apps/primecare_support/lib/features/support/screens/it_administrator_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to it administrator dashboard.`
* **User Story**: `As a Guest, I want to access the It Administrator Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `It Administrator Dashboard`
* **Acceptance Criteria**:
- The It Administrator Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `it_administrator_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `it_administrator_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `it_administrator_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7935` (Required: 1)
* Component ID: `7936` (Required: 1)
* Component ID: `7937` (Required: 1)
* Component ID: `7938` (Required: 1)
* Component ID: `7939` (Required: 1)
* Component ID: `7940` (Required: 1)
* Component ID: `7941` (Required: 1)

## 7. API / Data Mapping
* API ID: `5311` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `it_administrator_dashboard_runtime`
* **Test Name**: `It Administrator Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `It Administrator Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/it-administrator-dashboard`)
3. **should_be_visible** (Selector: `it_administrator_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `it_administrator_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `it_administrator_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
