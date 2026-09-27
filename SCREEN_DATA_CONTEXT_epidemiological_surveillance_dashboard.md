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
* **Test Name**: `Epidemiological Surveillance Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Epidemiological Surveillance Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/epidemiological-surveillance-dashboard`)
3. **should_be_visible** (Selector: `epidemiological_surveillance_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `epidemiological_surveillance_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `epidemiological_surveillance_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
