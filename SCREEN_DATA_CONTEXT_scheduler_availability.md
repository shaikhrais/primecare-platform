# SCREEN DATA CONTEXT: scheduler_availability

Below are the database records from `governance.db` used to configure and build the **Guest - SchedulerAvailabilityScreen** screen.

---

## 1. Screen Record
* **ID**: `970`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `scheduler_availability`
* **Screen Name**: `SchedulerAvailabilityScreen`
* **Route Path**: `/generated/scheduler-availability`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/scheduler_availability_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to scheduler availability.`
* **User Story**: `As a Guest, I want to access the Scheduler Availability within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Scheduler Availability`
* **Acceptance Criteria**:
- The Scheduler Availability route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_availability-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_availability-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_availability-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8284` (Required: 1)
* Component ID: `8285` (Required: 1)
* Component ID: `8286` (Required: 1)
* Component ID: `8287` (Required: 1)
* Component ID: `8288` (Required: 1)
* Component ID: `8289` (Required: 1)

## 7. API / Data Mapping
* API ID: `5408` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_availability_runtime`
* **Test Name**: `Scheduler Availability Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scheduler Availability`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/scheduler-availability`)
3. **should_be_visible** (Selector: `scheduler_availability-screen`, Value: `None`)
4. **should_be_visible** (Selector: `scheduler_availability-title`, Value: `None`)
5. **should_be_visible** (Selector: `scheduler_availability-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
