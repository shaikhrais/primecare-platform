# SCREEN DATA CONTEXT: school_health_program_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - SchoolHealthProgramDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `1003`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `school_health_program_dashboard`
* **Screen Name**: `SchoolHealthProgramDashboardScreen`
* **Route Path**: `/generated/school-health-program-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/public_health/school_health_program_dashboard.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to school health program dashboard.`
* **User Story**: `As a Guest, I want to access the School Health Program Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `School Health Program Dashboard`
* **Acceptance Criteria**:
- The School Health Program Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `school_health_program_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `school_health_program_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `school_health_program_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8495` (Required: 1)
* Component ID: `8496` (Required: 1)
* Component ID: `8497` (Required: 1)
* Component ID: `8498` (Required: 1)
* Component ID: `8499` (Required: 1)
* Component ID: `8500` (Required: 1)
* Component ID: `8501` (Required: 1)
* Component ID: `8502` (Required: 1)

## 7. API / Data Mapping
* API ID: `5465` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `school_health_program_dashboard_runtime`
* **Test Name**: `School Health Program Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `School Health Program Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/school-health-program-dashboard`)
3. **should_be_visible** (Selector: `school_health_program_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `school_health_program_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `school_health_program_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
