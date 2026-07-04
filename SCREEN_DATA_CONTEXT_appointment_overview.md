# SCREEN DATA CONTEXT: appointment_overview

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - AppointmentOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `506`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `appointment_overview`
* **Screen Name**: `AppointmentOverviewScreen`
* **Route Path**: `/executive/appointment-overview`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/appointment_overview_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `9`
* **App Code**: `fr`
* **App Name**: `Primecare Franchise`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to appointmentoverviewscreen.`
* **User Story**: `As a Franchise Owner, I want to access the AppointmentOverviewScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `AppointmentOverviewScreen`
* **Acceptance Criteria**:
- The AppointmentOverviewScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `appointment_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `appointment_overview-title` (Type: header, Required: 1)
* **primary_content** -> `appointment_overview-content` (Type: layout, Required: 1)
* **appointmentoverview_btn_2** -> `appointmentoverview-btn-2` (Type: button, Required: 0)
* **appointmentoverview_btn_3** -> `appointmentoverview-btn-3` (Type: button, Required: 0)
* **appointmentoverview_content** -> `appointmentoverview-content` (Type: layout, Required: 0)
* **appointmentoverview_screen** -> `appointmentoverview-screen` (Type: layout, Required: 0)
* **appointmentoverview_btn_1** -> `appointmentoverview-btn-1` (Type: button, Required: 0)
* **appointmentoverview_title** -> `appointmentoverview-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `435` (Required: 1)
* Component ID: `969` (Required: 1)
* Component ID: `1503` (Required: 1)
* Component ID: `5440` (Required: 1)
* Component ID: `5441` (Required: 1)
* Component ID: `5442` (Required: 1)
* Component ID: `5443` (Required: 1)
* Component ID: `5444` (Required: 1)
* Component ID: `5445` (Required: 1)
* Component ID: `5446` (Required: 1)
* Component ID: `5447` (Required: 1)
* Component ID: `5448` (Required: 1)
* Component ID: `5449` (Required: 1)

## 7. API / Data Mapping
* API ID: `4823` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `appointment_overview_runtime`
* **Test Name**: `AppointmentOverviewScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `AppointmentOverviewScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/executive/appointment-overview`)
3. **should_be_visible** (Selector: `appointment_overview-screen`, Value: `None`)
4. **should_be_visible** (Selector: `appointment_overview-title`, Value: `None`)
5. **should_be_visible** (Selector: `appointment_overview-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
