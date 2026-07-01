# SCREEN DATA CONTEXT: appointment

Below are the database records from `governance.db` used to configure and build the **Patient - AppointmentScreen** screen.

---

## 1. Screen Record
* **ID**: `569`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `appointment`
* **Screen Name**: `AppointmentScreen`
* **Route Path**: `/common/appointment`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/appointment_screen.dart`
* **Stage/Status**: `production_ready`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `15`
* **Role Code**: `patient`
* **Role Name**: `Patient`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to appointmentscreen.`
* **User Story**: `As a Patient, I want to access the AppointmentScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `AppointmentScreen`
* **Acceptance Criteria**:
- The AppointmentScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `appointment-screen` (Type: layout, Required: 1)
* **page_title** -> `appointment-title` (Type: header, Required: 1)
* **primary_content** -> `appointment-content` (Type: layout, Required: 1)
* **appointment_loading** -> `appointment-loading` (Type: loading, Required: 0)
* **appointment_btn_2** -> `appointment-btn-2` (Type: button, Required: 0)
* **appointment_btn_3** -> `appointment-btn-3` (Type: button, Required: 0)
* **appointment_btn_1** -> `appointment-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `493` (Required: 1)
* Component ID: `1027` (Required: 1)
* Component ID: `1561` (Required: 1)
* Component ID: `5979` (Required: 1)
* Component ID: `5980` (Required: 1)
* Component ID: `5981` (Required: 1)
* Component ID: `5982` (Required: 1)
* Component ID: `5983` (Required: 1)

## 7. API / Data Mapping
* API ID: `4823` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `appointment_runtime`
* **Test Name**: `AppointmentScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Appointment`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Appointment`)
4. **click_sidebar_link** (Selector: `None`, Value: `Appointment`)
5. **check_url** (Selector: `None`, Value: `/common/appointment`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
