# SCREEN DATA CONTEXT: legal_dashboard

Below are the database records from `governance.db` used to configure and build the **Legal Counsel - LegalDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `40`
* **App ID**: `5`
* **Role ID**: `28`
* **Screen Code**: `legal_dashboard`
* **Screen Name**: `LegalDashboardScreen`
* **Route Path**: `/offices/corporate/roles/legal/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/legal_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `28`
* **Role Code**: `legal`
* **Role Name**: `Legal Counsel`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Legal Counsel personnel to oversee, audit, and coordinate operations related to legaldashboardscreen.`
* **User Story**: `As a Legal Counsel, I want to access the LegalDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `LegalDashboardScreen`
* **Acceptance Criteria**:
- The LegalDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Legal Counsel access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `legal_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `legal_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `legal_dashboard-content` (Type: layout, Required: 1)
* **legaldashboard_btn_1** -> `legaldashboard-btn-1` (Type: button, Required: 0)
* **legaldashboard_btn_2** -> `legaldashboard-btn-2` (Type: button, Required: 0)
* **legaldashboard_content** -> `legaldashboard-content` (Type: layout, Required: 0)
* **legaldashboard_title** -> `legaldashboard-title` (Type: header, Required: 0)
* **legaldashboard_btn_3** -> `legaldashboard-btn-3` (Type: button, Required: 0)
* **legaldashboard_loading** -> `legaldashboard-loading` (Type: loading, Required: 0)
* **legaldashboard_screen** -> `legaldashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `48` (Required: 1)
* Component ID: `582` (Required: 1)
* Component ID: `1116` (Required: 1)
* Component ID: `1933` (Required: 1)
* Component ID: `1934` (Required: 1)
* Component ID: `1935` (Required: 1)
* Component ID: `1936` (Required: 1)
* Component ID: `1937` (Required: 1)
* Component ID: `1938` (Required: 1)
* Component ID: `1939` (Required: 1)
* Component ID: `1940` (Required: 1)
* Component ID: `1941` (Required: 1)
* Component ID: `1942` (Required: 1)

## 7. API / Data Mapping
* API ID: `4295` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `legal_dashboard_runtime`
* **Test Name**: `LegalDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `LegalDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `legal`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/legal/dashboard`)
3. **should_be_visible** (Selector: `legal_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `legal_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `legal_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
