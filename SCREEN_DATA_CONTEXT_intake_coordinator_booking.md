# SCREEN DATA CONTEXT: intake_coordinator_booking

Below are the database records from `governance.db` used to configure and build the **Volunteer Coordinator - IntakeCoordinatorBookingScreen** screen.

---

## 1. Screen Record
* **ID**: `385`
* **App ID**: `5`
* **Role ID**: `48`
* **Screen Code**: `intake_coordinator_booking`
* **Screen Name**: `IntakeCoordinatorBookingScreen`
* **Route Path**: `/executive/intake-coordinator-booking`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_booking_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `48`
* **Role Code**: `volunteer_coordinator`
* **Role Name**: `Volunteer Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Volunteer Coordinator personnel to oversee, audit, and coordinate operations related to intakecoordinatorbookingscreen.`
* **User Story**: `As a Volunteer Coordinator, I want to access the IntakeCoordinatorBookingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeCoordinatorBookingScreen`
* **Acceptance Criteria**:
- The IntakeCoordinatorBookingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_coordinator_booking-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_coordinator_booking-title` (Type: header, Required: 1)
* **primary_content** -> `intake_coordinator_booking-content` (Type: layout, Required: 1)
* **intakecoordinatorbooking_btn_3** -> `intakecoordinatorbooking-btn-3` (Type: button, Required: 0)
* **intakecoordinatorbooking_btn_2** -> `intakecoordinatorbooking-btn-2` (Type: button, Required: 0)
* **intakecoordinatorbooking_btn_1** -> `intakecoordinatorbooking-btn-1` (Type: button, Required: 0)
* **intakecoordinatorbooking_content** -> `intakecoordinatorbooking-content` (Type: layout, Required: 0)
* **intakecoordinatorbooking_screen** -> `intakecoordinatorbooking-screen` (Type: layout, Required: 0)
* **intakecoordinatorbooking_title** -> `intakecoordinatorbooking-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `391` (Required: 1)
* Component ID: `925` (Required: 1)
* Component ID: `1459` (Required: 1)
* Component ID: `5015` (Required: 1)
* Component ID: `5016` (Required: 1)
* Component ID: `5017` (Required: 1)
* Component ID: `5018` (Required: 1)
* Component ID: `5019` (Required: 1)

## 7. API / Data Mapping
* API ID: `4772` (Required: 1)
* API ID: `4773` (Required: 1)
* API ID: `4774` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_coordinator_booking_runtime`
* **Test Name**: `IntakeCoordinatorBookingScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Intake Coordinator Booking`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer_coordinator`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Intake Coordinator Booking`)
4. **click_sidebar_link** (Selector: `None`, Value: `Intake Coordinator Booking`)
5. **check_url** (Selector: `None`, Value: `/executive/intake-coordinator-booking`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
