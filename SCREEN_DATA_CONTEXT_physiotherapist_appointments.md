# SCREEN DATA CONTEXT: physiotherapist_appointments

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistAppointmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `336`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_appointments`
* **Screen Name**: `PhysiotherapistAppointmentsScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/appointments`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_appointments_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistappointmentsscreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistAppointmentsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistAppointmentsScreen`
* **Acceptance Criteria**:
- The PhysiotherapistAppointmentsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_appointments-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_appointments-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_appointments-content` (Type: layout, Required: 1)
* **physiotherapistappointments_screen** -> `physiotherapistappointments-screen` (Type: layout, Required: 0)
* **physiotherapistappointments_content** -> `physiotherapistappointments-content` (Type: layout, Required: 0)
* **physiotherapistappointments_title** -> `physiotherapistappointments-title` (Type: header, Required: 0)
* **physiotherapistappointments_btn_3** -> `physiotherapistappointments-btn-3` (Type: button, Required: 0)
* **physiotherapistappointments_btn_2** -> `physiotherapistappointments-btn-2` (Type: button, Required: 0)
* **physiotherapistappointments_btn_1** -> `physiotherapistappointments-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `344` (Required: 1)
* Component ID: `878` (Required: 1)
* Component ID: `1412` (Required: 1)
* Component ID: `4571` (Required: 1)
* Component ID: `4572` (Required: 1)
* Component ID: `4573` (Required: 1)
* Component ID: `4574` (Required: 1)
* Component ID: `4575` (Required: 1)
* Component ID: `4576` (Required: 1)
* Component ID: `4577` (Required: 1)
* Component ID: `4578` (Required: 1)

## 7. API / Data Mapping
* API ID: `4665` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_appointments_runtime`
* **Test Name**: `PhysiotherapistAppointmentsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Physiotherapist Appointments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Physiotherapist Appointments`)
4. **click_sidebar_link** (Selector: `None`, Value: `Physiotherapist Appointments`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/appointments`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
