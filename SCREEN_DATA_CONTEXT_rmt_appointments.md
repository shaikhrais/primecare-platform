# SCREEN DATA CONTEXT: rmt_appointments

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtAppointmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `353`
* **App ID**: `6`
* **Role ID**: `3`
* **Screen Code**: `rmt_appointments`
* **Screen Name**: `RmtAppointmentsScreen`
* **Route Path**: `/offices/clinical/roles/rmt/appointments`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_appointments_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtappointmentsscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtAppointmentsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtAppointmentsScreen`
* **Acceptance Criteria**:
- The RmtAppointmentsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_appointments-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_appointments-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_appointments-content` (Type: layout, Required: 1)
* **rmtappointments_btn_2** -> `rmtappointments-btn-2` (Type: button, Required: 0)
* **rmtappointments_loading** -> `rmtappointments-loading` (Type: loading, Required: 0)
* **rmtappointments_btn_3** -> `rmtappointments-btn-3` (Type: button, Required: 0)
* **rmtappointments_screen** -> `rmtappointments-screen` (Type: layout, Required: 0)
* **rmtappointments_content** -> `rmtappointments-content` (Type: layout, Required: 0)
* **rmtappointments_title** -> `rmtappointments-title` (Type: header, Required: 0)
* **rmtappointments_btn_1** -> `rmtappointments-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `359` (Required: 1)
* Component ID: `893` (Required: 1)
* Component ID: `1427` (Required: 1)
* Component ID: `4708` (Required: 1)
* Component ID: `4709` (Required: 1)
* Component ID: `4710` (Required: 1)
* Component ID: `4711` (Required: 1)
* Component ID: `4712` (Required: 1)
* Component ID: `4713` (Required: 1)
* Component ID: `4714` (Required: 1)
* Component ID: `4715` (Required: 1)
* Component ID: `4716` (Required: 1)
* Component ID: `4717` (Required: 1)

## 7. API / Data Mapping
* API ID: `4686` (Required: 1)
* API ID: `4687` (Required: 1)
* API ID: `4688` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_appointments_runtime`
* **Test Name**: `RmtAppointmentsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Appointments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Appointments`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Appointments`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/appointments`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
