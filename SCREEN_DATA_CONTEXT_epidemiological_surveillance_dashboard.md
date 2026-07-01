# SCREEN DATA CONTEXT: epidemiological_surveillance_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - EpidemiologicalSurveillanceDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `1000`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `epidemiological_surveillance_dashboard`
* **Screen Name**: `EpidemiologicalSurveillanceDashboardScreen`
* **Route Path**: `/generated/epidemiological-surveillance-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/public_health/epidemiological_surveillance_dashboard.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to epidemiological surveillance dashboard.`
* **User Story**: `As a Guest, I want to access the Epidemiological Surveillance Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Epidemiological Surveillance Dashboard`
* **Acceptance Criteria**:
- The Epidemiological Surveillance Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `epidemiological_surveillance_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `epidemiological_surveillance_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `epidemiological_surveillance_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8472` (Required: 1)
* Component ID: `8473` (Required: 1)
* Component ID: `8474` (Required: 1)
* Component ID: `8475` (Required: 1)
* Component ID: `8476` (Required: 1)
* Component ID: `8477` (Required: 1)
* Component ID: `8478` (Required: 1)

## 7. API / Data Mapping
* API ID: `5462` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `epidemiological_surveillance_dashboard_runtime`
* **Test Name**: `Epidemiological Surveillance Dashboard Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Epidemiological Surveillance Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Epidemiological Surveillance Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Epidemiological Surveillance Dashboard`)
5. **check_url** (Selector: `None`, Value: `/generated/epidemiological-surveillance-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
