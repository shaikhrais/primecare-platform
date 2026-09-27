# SCREEN DATA CONTEXT: booking

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - BookingScreen** screen.

---

## 1. Screen Record
* **ID**: `551`
* **App ID**: `6`
* **Role ID**: `7`
* **Screen Code**: `booking`
* **Screen Name**: `BookingScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/booking`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/booking_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `7`
* **Role Code**: `intake`
* **Role Name**: `Intake Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to bookingscreen.`
* **User Story**: `As a Intake Coordinator, I want to access the BookingScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BookingScreen`
* **Acceptance Criteria**:
- The BookingScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `booking-screen` (Type: layout, Required: 1)
* **page_title** -> `booking-title` (Type: header, Required: 1)
* **primary_content** -> `booking-content` (Type: layout, Required: 1)
* **booking_loading** -> `booking-loading` (Type: loading, Required: 0)
* **booking_btn_1** -> `booking-btn-1` (Type: button, Required: 0)
* **booking_btn_2** -> `booking-btn-2` (Type: button, Required: 0)
* **booking_btn_3** -> `booking-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `475` (Required: 1)
* Component ID: `1009` (Required: 1)
* Component ID: `1543` (Required: 1)
* Component ID: `5816` (Required: 1)
* Component ID: `5817` (Required: 1)
* Component ID: `5818` (Required: 1)
* Component ID: `5819` (Required: 1)
* Component ID: `5820` (Required: 1)
* Component ID: `5821` (Required: 1)
* Component ID: `5822` (Required: 1)
* Component ID: `5823` (Required: 1)
* Component ID: `5824` (Required: 1)

## 7. API / Data Mapping
* API ID: `4892` (Required: 1)
* API ID: `4893` (Required: 1)
* API ID: `4894` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `booking_runtime`
* **Test Name**: `BookingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `BookingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/booking`)
3. **should_be_visible** (Selector: `booking-screen`, Value: `None`)
4. **should_be_visible** (Selector: `booking-title`, Value: `None`)
5. **should_be_visible** (Selector: `booking-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
