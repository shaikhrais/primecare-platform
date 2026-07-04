# SCREEN DATA CONTEXT: shareholder_dashboard

Below are the database records from `governance.db` used to configure and build the **Shareholder - ShareholderDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `42`
* **App ID**: `5`
* **Role ID**: `30`
* **Screen Code**: `shareholder_dashboard`
* **Screen Name**: `ShareholderDashboardScreen`
* **Route Path**: `/offices/corporate/roles/shareholder/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/shareholder_dashboard.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `30`
* **Role Code**: `shareholder`
* **Role Name**: `Shareholder`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shareholder personnel to oversee, audit, and coordinate operations related to shareholderdashboardscreen.`
* **User Story**: `As a Shareholder, I want to access the ShareholderDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ShareholderDashboardScreen`
* **Acceptance Criteria**:
- The ShareholderDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shareholder access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `shareholder_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `shareholder_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `shareholder_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `50` (Required: 1)
* Component ID: `584` (Required: 1)
* Component ID: `1118` (Required: 1)
* Component ID: `1953` (Required: 1)
* Component ID: `1954` (Required: 1)
* Component ID: `1955` (Required: 1)
* Component ID: `1956` (Required: 1)
* Component ID: `1957` (Required: 1)
* Component ID: `1958` (Required: 1)
* Component ID: `1959` (Required: 1)
* Component ID: `1960` (Required: 1)

## 7. API / Data Mapping
* API ID: `4297` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `shareholder_dashboard_runtime`
* **Test Name**: `ShareholderDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ShareholderDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `shareholder`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/shareholder/dashboard`)
3. **should_be_visible** (Selector: `shareholder_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `shareholder_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `shareholder_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
