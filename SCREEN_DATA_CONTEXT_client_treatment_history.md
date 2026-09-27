# SCREEN DATA CONTEXT: client_treatment_history

Below are the database records from `governance.db` used to configure and build the **Guest - ClientTreatmentHistoryScreen** screen.

---

## 1. Screen Record
* **ID**: `666`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `client_treatment_history`
* **Screen Name**: `ClientTreatmentHistoryScreen`
* **Route Path**: `/generated/client-treatment-history`
* **Actual File Path**: `apps/primecare_client/lib/features/generated_screens/client_treatment_history_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to client treatment history.`
* **User Story**: `As a Guest, I want to access the Client Treatment History within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Client Treatment History`
* **Acceptance Criteria**:
- The Client Treatment History route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `client_treatment_history-screen` (Type: layout, Required: 1)
* **page_title** -> `client_treatment_history-title` (Type: header, Required: 1)
* **primary_content** -> `client_treatment_history-content` (Type: layout, Required: 1)
* **clienttreatmenthistoryscreen_screen** -> `clienttreatmenthistoryscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6658` (Required: 1)
* Component ID: `6659` (Required: 1)
* Component ID: `6660` (Required: 1)
* Component ID: `6661` (Required: 1)
* Component ID: `6662` (Required: 1)

## 7. API / Data Mapping
* API ID: `5026` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `client_treatment_history_runtime`
* **Test Name**: `Client Treatment History Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Client Treatment History`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/client-treatment-history`)
3. **should_be_visible** (Selector: `client_treatment_history-screen`, Value: `None`)
4. **should_be_visible** (Selector: `client_treatment_history-title`, Value: `None`)
5. **should_be_visible** (Selector: `client_treatment_history-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
