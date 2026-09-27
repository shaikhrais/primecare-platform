# SCREEN DATA CONTEXT: cto_infrastructure

Below are the database records from `governance.db` used to configure and build the **Guest - CtoInfrastructureScreen** screen.

---

## 1. Screen Record
* **ID**: `750`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cto_infrastructure`
* **Screen Name**: `CtoInfrastructureScreen`
* **Route Path**: `/offices/corporate/roles/cto/infrastructure`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cto_infrastructure_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cto infrastructure.`
* **User Story**: `As a Guest, I want to access the Cto Infrastructure within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cto Infrastructure`
* **Acceptance Criteria**:
- The Cto Infrastructure route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_infrastructure-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_infrastructure-title` (Type: header, Required: 1)
* **primary_content** -> `cto_infrastructure-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7119` (Required: 1)
* Component ID: `7120` (Required: 1)
* Component ID: `7121` (Required: 1)
* Component ID: `7122` (Required: 1)
* Component ID: `7123` (Required: 1)

## 7. API / Data Mapping
* API ID: `5138` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_infrastructure_runtime`
* **Test Name**: `Cto Infrastructure Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cto Infrastructure`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cto/infrastructure`)
3. **should_be_visible** (Selector: `cto_infrastructure-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cto_infrastructure-title`, Value: `None`)
5. **should_be_visible** (Selector: `cto_infrastructure-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
