# SCREEN DATA CONTEXT: cto_system_health

Below are the database records from `governance.db` used to configure and build the **Guest - CtoSystemHealthScreen** screen.

---

## 1. Screen Record
* **ID**: `756`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cto_system_health`
* **Screen Name**: `CtoSystemHealthScreen`
* **Route Path**: `/offices/corporate/roles/cto/system-health`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cto_system_health_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cto system health.`
* **User Story**: `As a Guest, I want to access the Cto System Health within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cto System Health`
* **Acceptance Criteria**:
- The Cto System Health route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_system_health-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_system_health-title` (Type: header, Required: 1)
* **primary_content** -> `cto_system_health-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7152` (Required: 1)
* Component ID: `7153` (Required: 1)
* Component ID: `7154` (Required: 1)
* Component ID: `7155` (Required: 1)
* Component ID: `7156` (Required: 1)
* Component ID: `7157` (Required: 1)

## 7. API / Data Mapping
* API ID: `5146` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_system_health_runtime`
* **Test Name**: `Cto System Health Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cto System Health`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cto/system-health`)
3. **should_be_visible** (Selector: `cto_system_health-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cto_system_health-title`, Value: `None`)
5. **should_be_visible** (Selector: `cto_system_health-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
