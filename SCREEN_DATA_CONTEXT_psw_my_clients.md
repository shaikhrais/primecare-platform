# SCREEN DATA CONTEXT: psw_my_clients

Below are the database records from `governance.db` used to configure and build the **Guest - PswMyClientsScreen** screen.

---

## 1. Screen Record
* **ID**: `697`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_my_clients`
* **Screen Name**: `PswMyClientsScreen`
* **Route Path**: `/generated/psw-my-clients`
* **Actual File Path**: `apps/primecare_clinic/lib/features/psw/screens/psw_my_clients_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw my clients.`
* **User Story**: `As a Guest, I want to access the Psw My Clients within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw My Clients`
* **Acceptance Criteria**:
- The Psw My Clients route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_my_clients-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_my_clients-title` (Type: header, Required: 1)
* **primary_content** -> `psw_my_clients-content` (Type: layout, Required: 1)
* **clientlist_view** -> `clientlist-view` (Type: data_display, Required: 0)
* **pswmyclients_content** -> `pswmyclients-content` (Type: layout, Required: 0)
* **clientsearch_bar** -> `clientsearch-bar` (Type: custom, Required: 0)
* **clientactivity_log** -> `clientactivity-log` (Type: custom, Required: 0)

## 6. Component Mapping
* Component ID: `6827` (Required: 1)
* Component ID: `6828` (Required: 1)
* Component ID: `6829` (Required: 1)
* Component ID: `6830` (Required: 1)
* Component ID: `6831` (Required: 1)

## 7. API / Data Mapping
* API ID: `5069` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_my_clients_runtime`
* **Test Name**: `Psw My Clients Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw My Clients`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/psw-my-clients`)
3. **should_be_visible** (Selector: `psw_my_clients-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_my_clients-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_my_clients-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
