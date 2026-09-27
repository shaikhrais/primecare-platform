# SCREEN DATA CONTEXT: client_intake

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - ClientIntakeScreen** screen.

---

## 1. Screen Record
* **ID**: `550`
* **App ID**: `6`
* **Role ID**: `7`
* **Screen Code**: `client_intake`
* **Screen Name**: `ClientIntakeScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/client-intake`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/client_intake_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to clientintakescreen.`
* **User Story**: `As a Intake Coordinator, I want to access the ClientIntakeScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClientIntakeScreen`
* **Acceptance Criteria**:
- The ClientIntakeScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `client_intake-screen` (Type: layout, Required: 1)
* **page_title** -> `client_intake-title` (Type: header, Required: 1)
* **primary_content** -> `client_intake-content` (Type: layout, Required: 1)
* **clientintake_btn_1** -> `clientintake-btn-1` (Type: button, Required: 0)
* **clientintake_screen** -> `clientintake-screen` (Type: layout, Required: 0)
* **clientintake_content** -> `clientintake-content` (Type: layout, Required: 0)
* **clientintake_btn_3** -> `clientintake-btn-3` (Type: button, Required: 0)
* **clientintake_title** -> `clientintake-title` (Type: header, Required: 0)
* **clientintake_loading** -> `clientintake-loading` (Type: loading, Required: 0)
* **clientintake_btn_2** -> `clientintake-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `474` (Required: 1)
* Component ID: `1008` (Required: 1)
* Component ID: `1542` (Required: 1)
* Component ID: `5808` (Required: 1)
* Component ID: `5809` (Required: 1)
* Component ID: `5810` (Required: 1)
* Component ID: `5811` (Required: 1)
* Component ID: `5812` (Required: 1)
* Component ID: `5813` (Required: 1)
* Component ID: `5814` (Required: 1)
* Component ID: `5815` (Required: 1)

## 7. API / Data Mapping
* API ID: `4889` (Required: 1)
* API ID: `4890` (Required: 1)
* API ID: `4891` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `client_intake_runtime`
* **Test Name**: `ClientIntakeScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClientIntakeScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/client-intake`)
3. **should_be_visible** (Selector: `client_intake-screen`, Value: `None`)
4. **should_be_visible** (Selector: `client_intake-title`, Value: `None`)
5. **should_be_visible** (Selector: `client_intake-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
