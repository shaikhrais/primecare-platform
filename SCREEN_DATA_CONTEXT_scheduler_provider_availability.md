# SCREEN DATA CONTEXT: scheduler_provider_availability

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulerProviderAvailabilityScreen** screen.

---

## 1. Screen Record
* **ID**: `381`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `scheduler_provider_availability`
* **Screen Name**: `SchedulerProviderAvailabilityScreen`
* **Route Path**: `/staff/scheduler-provider-availability`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduler_provider_availability_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `60`
* **Role Code**: `scheduler`
* **Role Name**: `Shift Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to schedulerprovideravailabilityscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulerProviderAvailabilityScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulerProviderAvailabilityScreen`
* **Acceptance Criteria**:
- The SchedulerProviderAvailabilityScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_provider_availability-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_provider_availability-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_provider_availability-content` (Type: layout, Required: 1)
* **schedulerprovideravailability_btn_1** -> `schedulerprovideravailability-btn-1` (Type: button, Required: 0)
* **schedulerprovideravailability_btn_2** -> `schedulerprovideravailability-btn-2` (Type: button, Required: 0)
* **schedulerprovideravailability_btn_5** -> `schedulerprovideravailability-btn-5` (Type: button, Required: 0)
* **schedulerprovideravailability_btn_3** -> `schedulerprovideravailability-btn-3` (Type: button, Required: 0)
* **schedulerprovideravailability_screen** -> `schedulerprovideravailability-screen` (Type: layout, Required: 0)
* **schedulerprovideravailability_content** -> `schedulerprovideravailability-content` (Type: layout, Required: 0)
* **schedulerprovideravailability_btn_4** -> `schedulerprovideravailability-btn-4` (Type: button, Required: 0)
* **schedulerprovideravailability_title** -> `schedulerprovideravailability-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `387` (Required: 1)
* Component ID: `921` (Required: 1)
* Component ID: `1455` (Required: 1)
* Component ID: `4982` (Required: 1)
* Component ID: `4983` (Required: 1)
* Component ID: `4984` (Required: 1)
* Component ID: `4985` (Required: 1)
* Component ID: `4986` (Required: 1)
* Component ID: `4987` (Required: 1)
* Component ID: `4988` (Required: 1)
* Component ID: `4989` (Required: 1)

## 7. API / Data Mapping
* API ID: `4762` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_provider_availability_runtime`
* **Test Name**: `SchedulerProviderAvailabilityScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SchedulerProviderAvailabilityScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/scheduler-provider-availability`)
3. **should_be_visible** (Selector: `scheduler_provider_availability-screen`, Value: `None`)
4. **should_be_visible** (Selector: `scheduler_provider_availability-title`, Value: `None`)
5. **should_be_visible** (Selector: `scheduler_provider_availability-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
