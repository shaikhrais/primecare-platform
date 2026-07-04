# SCREEN DATA CONTEXT: cto_api_monitoring

Below are the database records from `governance.db` used to configure and build the **Guest - CtoApiMonitoringScreen** screen.

---

## 1. Screen Record
* **ID**: `747`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cto_api_monitoring`
* **Screen Name**: `CtoApiMonitoringScreen`
* **Route Path**: `/offices/corporate/roles/cto/api-monitoring`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cto_api_monitoring_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cto api monitoring.`
* **User Story**: `As a Guest, I want to access the Cto Api Monitoring within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cto Api Monitoring`
* **Acceptance Criteria**:
- The Cto Api Monitoring route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_api_monitoring-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_api_monitoring-title` (Type: header, Required: 1)
* **primary_content** -> `cto_api_monitoring-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7101` (Required: 1)
* Component ID: `7102` (Required: 1)
* Component ID: `7103` (Required: 1)
* Component ID: `7104` (Required: 1)
* Component ID: `7105` (Required: 1)
* Component ID: `7106` (Required: 1)
* Component ID: `7107` (Required: 1)

## 7. API / Data Mapping
* API ID: `5135` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_api_monitoring_runtime`
* **Test Name**: `Cto Api Monitoring Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cto Api Monitoring`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cto/api-monitoring`)
3. **should_be_visible** (Selector: `cto_api_monitoring-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cto_api_monitoring-title`, Value: `None`)
5. **should_be_visible** (Selector: `cto_api_monitoring-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
