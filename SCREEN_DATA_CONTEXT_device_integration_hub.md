# SCREEN DATA CONTEXT: device_integration_hub

Below are the database records from `governance.db` used to configure and build the **Guest - DeviceIntegrationHubScreen** screen.

---

## 1. Screen Record
* **ID**: `1020`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `device_integration_hub`
* **Screen Name**: `DeviceIntegrationHubScreen`
* **Route Path**: `/generated/device-integration-hub`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/telehealth/device_integration_hub.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to device integration hub.`
* **User Story**: `As a Guest, I want to access the Device Integration Hub within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Device Integration Hub`
* **Acceptance Criteria**:
- The Device Integration Hub route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `device_integration_hub-screen` (Type: layout, Required: 1)
* **page_title** -> `device_integration_hub-title` (Type: header, Required: 1)
* **primary_content** -> `device_integration_hub-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8601` (Required: 1)
* Component ID: `8602` (Required: 1)
* Component ID: `8603` (Required: 1)
* Component ID: `8604` (Required: 1)
* Component ID: `8605` (Required: 1)
* Component ID: `8606` (Required: 1)
* Component ID: `8607` (Required: 1)

## 7. API / Data Mapping
* API ID: `5486` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `device_integration_hub_runtime`
* **Test Name**: `Device Integration Hub Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Device Integration Hub`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/device-integration-hub`)
3. **should_be_visible** (Selector: `device_integration_hub-screen`, Value: `None`)
4. **should_be_visible** (Selector: `device_integration_hub-title`, Value: `None`)
5. **should_be_visible** (Selector: `device_integration_hub-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
