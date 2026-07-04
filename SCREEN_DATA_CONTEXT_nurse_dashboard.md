# SCREEN DATA CONTEXT: nurse_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - NurseDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `683`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `nurse_dashboard`
* **Screen Name**: `NurseDashboardScreen`
* **Route Path**: `/generated/nurse-dashboard`
* **Actual File Path**: `apps/primecare_clinic/lib/features/generated_screens/nurse_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to nurse dashboard.`
* **User Story**: `As a Guest, I want to access the Nurse Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Nurse Dashboard`
* **Acceptance Criteria**:
- The Nurse Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `nurse_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `nurse_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `nurse_dashboard-content` (Type: layout, Required: 1)
* **nursedashboardscreen_screen** -> `nursedashboardscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6750` (Required: 1)
* Component ID: `6751` (Required: 1)
* Component ID: `6752` (Required: 1)
* Component ID: `6753` (Required: 1)
* Component ID: `6754` (Required: 1)
* Component ID: `6755` (Required: 1)
* Component ID: `6756` (Required: 1)
* Component ID: `6757` (Required: 1)

## 7. API / Data Mapping
* API ID: `5047` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `nurse_dashboard_runtime`
* **Test Name**: `Nurse Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Nurse Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/nurse-dashboard`)
3. **should_be_visible** (Selector: `nurse_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `nurse_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `nurse_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
