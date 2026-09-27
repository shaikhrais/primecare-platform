# SCREEN DATA CONTEXT: mobile_clinic_dispatch

Below are the database records from `governance.db` used to configure and build the **Guest - MobileClinicDispatchScreen** screen.

---

## 1. Screen Record
* **ID**: `1001`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `mobile_clinic_dispatch`
* **Screen Name**: `MobileClinicDispatchScreen`
* **Route Path**: `/generated/mobile-clinic-dispatch`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/public_health/mobile_clinic_dispatch.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to mobile clinic dispatch.`
* **User Story**: `As a Guest, I want to access the Mobile Clinic Dispatch within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Mobile Clinic Dispatch`
* **Acceptance Criteria**:
- The Mobile Clinic Dispatch route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `mobile_clinic_dispatch-screen` (Type: layout, Required: 1)
* **page_title** -> `mobile_clinic_dispatch-title` (Type: header, Required: 1)
* **primary_content** -> `mobile_clinic_dispatch-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8479` (Required: 1)
* Component ID: `8480` (Required: 1)
* Component ID: `8481` (Required: 1)
* Component ID: `8482` (Required: 1)
* Component ID: `8483` (Required: 1)
* Component ID: `8484` (Required: 1)
* Component ID: `8485` (Required: 1)
* Component ID: `8486` (Required: 1)

## 7. API / Data Mapping
* API ID: `5463` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `mobile_clinic_dispatch_runtime`
* **Test Name**: `Mobile Clinic Dispatch Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Mobile Clinic Dispatch`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/mobile-clinic-dispatch`)
3. **should_be_visible** (Selector: `mobile_clinic_dispatch-screen`, Value: `None`)
4. **should_be_visible** (Selector: `mobile_clinic_dispatch-title`, Value: `None`)
5. **should_be_visible** (Selector: `mobile_clinic_dispatch-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
