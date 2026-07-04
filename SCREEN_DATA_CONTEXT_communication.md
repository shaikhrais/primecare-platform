# SCREEN DATA CONTEXT: communication

Below are the database records from `governance.db` used to configure and build the **Customer Support - CommunicationScreen** screen.

---

## 1. Screen Record
* **ID**: `559`
* **App ID**: `5`
* **Role ID**: `61`
* **Screen Code**: `communication`
* **Screen Name**: `CommunicationScreen`
* **Route Path**: `/staff/communication`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/communication_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `61`
* **Role Code**: `customer_support`
* **Role Name**: `Customer Support`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Customer Support personnel to oversee, audit, and coordinate operations related to communicationscreen.`
* **User Story**: `As a Customer Support, I want to access the CommunicationScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CommunicationScreen`
* **Acceptance Criteria**:
- The CommunicationScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Customer Support access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `communication-screen` (Type: layout, Required: 1)
* **page_title** -> `communication-title` (Type: header, Required: 1)
* **primary_content** -> `communication-content` (Type: layout, Required: 1)
* **communication_loading** -> `communication-loading` (Type: loading, Required: 0)
* **communication_btn_4** -> `communication-btn-4` (Type: button, Required: 0)
* **communication_btn_1** -> `communication-btn-1` (Type: button, Required: 0)
* **communication_btn_2** -> `communication-btn-2` (Type: button, Required: 0)
* **communication_btn_5** -> `communication-btn-5` (Type: button, Required: 0)
* **communication_btn_3** -> `communication-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `483` (Required: 1)
* Component ID: `1017` (Required: 1)
* Component ID: `1551` (Required: 1)
* Component ID: `5890` (Required: 1)
* Component ID: `5891` (Required: 1)
* Component ID: `5892` (Required: 1)
* Component ID: `5893` (Required: 1)
* Component ID: `5894` (Required: 1)
* Component ID: `5895` (Required: 1)
* Component ID: `5896` (Required: 1)
* Component ID: `5897` (Required: 1)
* Component ID: `5898` (Required: 1)
* Component ID: `5899` (Required: 1)

## 7. API / Data Mapping
* API ID: `4906` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `communication_runtime`
* **Test Name**: `CommunicationScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CommunicationScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **visit** (Selector: `None`, Value: `/staff/communication`)
3. **should_be_visible** (Selector: `communication-screen`, Value: `None`)
4. **should_be_visible** (Selector: `communication-title`, Value: `None`)
5. **should_be_visible** (Selector: `communication-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
