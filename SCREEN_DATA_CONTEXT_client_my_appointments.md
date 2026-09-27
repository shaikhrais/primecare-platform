# SCREEN DATA CONTEXT: client_my_appointments

Below are the database records from `governance.db` used to configure and build the **Guest - ClientMyAppointmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `663`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `client_my_appointments`
* **Screen Name**: `ClientMyAppointmentsScreen`
* **Route Path**: `/generated/client-my-appointments`
* **Actual File Path**: `apps/primecare_client/lib/features/generated_screens/client_my_appointments_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to client my appointments.`
* **User Story**: `As a Guest, I want to access the Client My Appointments within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Client My Appointments`
* **Acceptance Criteria**:
- The Client My Appointments route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `client_my_appointments-screen` (Type: layout, Required: 1)
* **page_title** -> `client_my_appointments-title` (Type: header, Required: 1)
* **primary_content** -> `client_my_appointments-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6643` (Required: 1)
* Component ID: `6644` (Required: 1)
* Component ID: `6645` (Required: 1)
* Component ID: `6646` (Required: 1)
* Component ID: `6647` (Required: 1)

## 7. API / Data Mapping
* API ID: `5023` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `client_my_appointments_runtime`
* **Test Name**: `Client My Appointments Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Client My Appointments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/client-my-appointments`)
3. **should_be_visible** (Selector: `client_my_appointments-screen`, Value: `None`)
4. **should_be_visible** (Selector: `client_my_appointments-title`, Value: `None`)
5. **should_be_visible** (Selector: `client_my_appointments-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
