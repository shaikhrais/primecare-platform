# SCREEN DATA CONTEXT: chiropractor_appointments

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorAppointmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `291`
* **App ID**: `6`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_appointments`
* **Screen Name**: `ChiropractorAppointmentsScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/appointments`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_appointments_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorappointmentsscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorAppointmentsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorAppointmentsScreen`
* **Acceptance Criteria**:
- The ChiropractorAppointmentsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_appointments-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_appointments-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_appointments-content` (Type: layout, Required: 1)
* **chiropractorappointments_content** -> `chiropractorappointments-content` (Type: layout, Required: 0)
* **chiropractorappointments_btn_1** -> `chiropractorappointments-btn-1` (Type: button, Required: 0)
* **chiropractorappointments_screen** -> `chiropractorappointments-screen` (Type: layout, Required: 0)
* **chiropractorappointments_btn_3** -> `chiropractorappointments-btn-3` (Type: button, Required: 0)
* **chiropractorappointments_btn_2** -> `chiropractorappointments-btn-2` (Type: button, Required: 0)
* **chiropractorappointments_title** -> `chiropractorappointments-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `299` (Required: 1)
* Component ID: `833` (Required: 1)
* Component ID: `1367` (Required: 1)
* Component ID: `4184` (Required: 1)
* Component ID: `4185` (Required: 1)
* Component ID: `4186` (Required: 1)
* Component ID: `4187` (Required: 1)
* Component ID: `4188` (Required: 1)
* Component ID: `4189` (Required: 1)
* Component ID: `4190` (Required: 1)
* Component ID: `4191` (Required: 1)

## 7. API / Data Mapping
* API ID: `4614` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_appointments_runtime`
* **Test Name**: `ChiropractorAppointmentsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Chiropractor Appointments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Chiropractor Appointments`)
4. **click_sidebar_link** (Selector: `None`, Value: `Chiropractor Appointments`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/appointments`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
