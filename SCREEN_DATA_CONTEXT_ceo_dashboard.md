# SCREEN DATA CONTEXT: ceo_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - CeoDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `705`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `ceo_dashboard`
* **Screen Name**: `CeoDashboardScreen`
* **Route Path**: `/offices/corporate/roles/ceo/dashboard`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/ceo_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to ceo dashboard.`
* **User Story**: `As a Guest, I want to access the Ceo Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Ceo Dashboard`
* **Acceptance Criteria**:
- The Ceo Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ceo_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `ceo_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `ceo_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6866` (Required: 1)
* Component ID: `6867` (Required: 1)
* Component ID: `6868` (Required: 1)
* Component ID: `6869` (Required: 1)
* Component ID: `6870` (Required: 1)
* Component ID: `6871` (Required: 1)
* Component ID: `6872` (Required: 1)

## 7. API / Data Mapping
* API ID: `5081` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ceo_dashboard_runtime`
* **Test Name**: `Ceo Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Ceo Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/ceo/dashboard`)
3. **should_be_visible** (Selector: `ceo_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `ceo_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `ceo_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
