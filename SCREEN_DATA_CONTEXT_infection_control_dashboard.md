# SCREEN DATA CONTEXT: infection_control_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - InfectionControlDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `681`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `infection_control_dashboard`
* **Screen Name**: `InfectionControlDashboardScreen`
* **Route Path**: `/generated/infection-control-dashboard`
* **Actual File Path**: `apps/primecare_clinic/lib/features/generated_screens/infection_control_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to infection control dashboard.`
* **User Story**: `As a Guest, I want to access the Infection Control Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Infection Control Dashboard`
* **Acceptance Criteria**:
- The Infection Control Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `infection_control_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `infection_control_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `infection_control_dashboard-content` (Type: layout, Required: 1)
* **infectioncontroldashboardscreen_screen** -> `infectioncontroldashboardscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6740` (Required: 1)
* Component ID: `6741` (Required: 1)
* Component ID: `6742` (Required: 1)
* Component ID: `6743` (Required: 1)
* Component ID: `6744` (Required: 1)

## 7. API / Data Mapping
* API ID: `5043` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `infection_control_dashboard_runtime`
* **Test Name**: `Infection Control Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Infection Control Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/infection-control-dashboard`)
3. **should_be_visible** (Selector: `infection_control_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `infection_control_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `infection_control_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
