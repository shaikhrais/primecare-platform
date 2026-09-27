# SCREEN DATA CONTEXT: operations_manager_service_quality

Below are the database records from `governance.db` used to configure and build the **Guest - OperationsManagerServiceQualityScreen** screen.

---

## 1. Screen Record
* **ID**: `806`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `operations_manager_service_quality`
* **Screen Name**: `OperationsManagerServiceQualityScreen`
* **Route Path**: `/offices/franchise/roles/operations_manager/service-quality`
* **Actual File Path**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_service_quality_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to operations manager service quality.`
* **User Story**: `As a Guest, I want to access the Operations Manager Service Quality within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Operations Manager Service Quality`
* **Acceptance Criteria**:
- The Operations Manager Service Quality route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `operations_manager_service_quality-screen` (Type: layout, Required: 1)
* **page_title** -> `operations_manager_service_quality-title` (Type: header, Required: 1)
* **primary_content** -> `operations_manager_service_quality-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7415` (Required: 1)
* Component ID: `7416` (Required: 1)
* Component ID: `7417` (Required: 1)
* Component ID: `7418` (Required: 1)
* Component ID: `7419` (Required: 1)
* Component ID: `7420` (Required: 1)
* Component ID: `7421` (Required: 1)

## 7. API / Data Mapping
* API ID: `5194` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `operations_manager_service_quality_runtime`
* **Test Name**: `Operations Manager Service Quality Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Operations Manager Service Quality`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/operations_manager/service-quality`)
3. **should_be_visible** (Selector: `operations_manager_service_quality-screen`, Value: `None`)
4. **should_be_visible** (Selector: `operations_manager_service_quality-title`, Value: `None`)
5. **should_be_visible** (Selector: `operations_manager_service_quality-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
