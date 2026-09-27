# SCREEN DATA CONTEXT: psw_clients

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - MyClientsScreen** screen.

---

## 1. Screen Record
* **ID**: `232`
* **App ID**: `1`
* **Role ID**: `51`
* **Screen Code**: `psw_clients`
* **Screen Name**: `MyClientsScreen`
* **Route Path**: `/offices/clinical/roles/psw/patient-profile`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_clients_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswclientsscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswClientsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswClientsScreen`
* **Acceptance Criteria**:
- The PswClientsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_clients-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_clients-title` (Type: header, Required: 1)
* **primary_content** -> `psw_clients-content` (Type: layout, Required: 1)
* **pswclients_title** -> `pswclients-title` (Type: header, Required: 0)
* **psw_clients_screen_textfield_input_1** -> `psw_clients_screen_textfield_input_1` (Type: field, Required: 0)
* **pswclients_btn_1** -> `pswclients-btn-1` (Type: button, Required: 0)
* **pswclients_content** -> `pswclients-content` (Type: layout, Required: 0)
* **pswclients_screen** -> `pswclients-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `240` (Required: 1)
* Component ID: `774` (Required: 1)
* Component ID: `1308` (Required: 1)
* Component ID: `3652` (Required: 1)
* Component ID: `3653` (Required: 1)
* Component ID: `3654` (Required: 1)
* Component ID: `3655` (Required: 1)
* Component ID: `3656` (Required: 1)
* Component ID: `3657` (Required: 1)
* Component ID: `3658` (Required: 1)
* Component ID: `3659` (Required: 1)
* Component ID: `3660` (Required: 1)
* Component ID: `3661` (Required: 1)

## 7. API / Data Mapping
* API ID: `4523` (Required: 1)
* API ID: `4524` (Required: 1)
* API ID: `4525` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_clients_runtime`
* **Test Name**: `My Clients Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `My Clients`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/patient-profile`)
3. **should_be_visible** (Selector: `psw_clients-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_clients-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_clients-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
