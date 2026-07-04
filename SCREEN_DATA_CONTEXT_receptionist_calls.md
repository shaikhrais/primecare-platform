# SCREEN DATA CONTEXT: receptionist_calls

Below are the database records from `governance.db` used to configure and build the **Guest - ReceptionistCallsScreen** screen.

---

## 1. Screen Record
* **ID**: `968`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `receptionist_calls`
* **Screen Name**: `ReceptionistCallsScreen`
* **Route Path**: `/generated/receptionist-calls`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/receptionist_calls_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to receptionist calls.`
* **User Story**: `As a Guest, I want to access the Receptionist Calls within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Receptionist Calls`
* **Acceptance Criteria**:
- The Receptionist Calls route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `receptionist_calls-screen` (Type: layout, Required: 1)
* **page_title** -> `receptionist_calls-title` (Type: header, Required: 1)
* **primary_content** -> `receptionist_calls-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8275` (Required: 1)
* Component ID: `8276` (Required: 1)
* Component ID: `8277` (Required: 1)
* Component ID: `8278` (Required: 1)

## 7. API / Data Mapping
* API ID: `5406` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `receptionist_calls_runtime`
* **Test Name**: `Receptionist Calls Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Receptionist Calls`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/receptionist-calls`)
3. **should_be_visible** (Selector: `receptionist_calls-screen`, Value: `None`)
4. **should_be_visible** (Selector: `receptionist_calls-title`, Value: `None`)
5. **should_be_visible** (Selector: `receptionist_calls-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
