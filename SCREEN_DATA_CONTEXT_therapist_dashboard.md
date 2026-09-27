# SCREEN DATA CONTEXT: therapist_dashboard

Below are the database records from `governance.db` used to configure and build the **Therapist - TherapistDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `2`
* **App ID**: `6`
* **Role ID**: `5`
* **Screen Code**: `therapist_dashboard`
* **Screen Name**: `TherapistDashboardScreen`
* **Route Path**: `/offices/clinical/roles/therapist/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/therapist_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `5`
* **Role Code**: `therapist`
* **Role Name**: `Therapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Therapist personnel to oversee, audit, and coordinate operations related to therapistdashboardscreen.`
* **User Story**: `As a Therapist, I want to access the TherapistDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TherapistDashboardScreen`
* **Acceptance Criteria**:
- The TherapistDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Therapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `therapist_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `therapist_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `therapist_dashboard-content` (Type: layout, Required: 1)
* **therapistdashboard_btn_3** -> `therapistdashboard-btn-3` (Type: button, Required: 0)
* **therapistdashboard_btn_2** -> `therapistdashboard-btn-2` (Type: button, Required: 0)
* **therapistdashboard_content** -> `therapistdashboard-content` (Type: layout, Required: 0)
* **therapistdashboard_screen** -> `therapistdashboard-screen` (Type: layout, Required: 0)
* **therapistdashboard_btn_4** -> `therapistdashboard-btn-4` (Type: button, Required: 0)
* **therapistdashboard_btn_1** -> `therapistdashboard-btn-1` (Type: button, Required: 0)
* **therapistdashboard_btn_5** -> `therapistdashboard-btn-5` (Type: button, Required: 0)
* **therapistdashboard_title** -> `therapistdashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `10` (Required: 1)
* Component ID: `544` (Required: 1)
* Component ID: `1078` (Required: 1)
* Component ID: `1621` (Required: 1)
* Component ID: `1622` (Required: 1)
* Component ID: `1623` (Required: 1)
* Component ID: `1624` (Required: 1)

## 7. API / Data Mapping
* API ID: `4251` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `therapist_dashboard_runtime`
* **Test Name**: `TherapistDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TherapistDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `therapist`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/therapist/dashboard`)
3. **should_be_visible** (Selector: `therapist_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `therapist_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `therapist_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
