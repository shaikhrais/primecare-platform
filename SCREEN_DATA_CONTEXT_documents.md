# SCREEN DATA CONTEXT: documents

Below are the database records from `governance.db` used to configure and build the **Patient - DocumentsScreen** screen.

---

## 1. Screen Record
* **ID**: `572`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `documents`
* **Screen Name**: `DocumentsScreen`
* **Route Path**: `/common/documents`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/documents_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `15`
* **Role Code**: `patient`
* **Role Name**: `Patient`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to documentsscreen.`
* **User Story**: `As a Patient, I want to access the DocumentsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `DocumentsScreen`
* **Acceptance Criteria**:
- The DocumentsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `documents-screen` (Type: layout, Required: 1)
* **page_title** -> `documents-title` (Type: header, Required: 1)
* **primary_content** -> `documents-content` (Type: layout, Required: 1)
* **documents_btn_1** -> `documents-btn-1` (Type: button, Required: 0)
* **documents_btn_3** -> `documents-btn-3` (Type: button, Required: 0)
* **documents_loading** -> `documents-loading` (Type: loading, Required: 0)
* **documents_btn_2** -> `documents-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `496` (Required: 1)
* Component ID: `1030` (Required: 1)
* Component ID: `1564` (Required: 1)
* Component ID: `5995` (Required: 1)
* Component ID: `5996` (Required: 1)
* Component ID: `5997` (Required: 1)
* Component ID: `5998` (Required: 1)
* Component ID: `5999` (Required: 1)

## 7. API / Data Mapping
* API ID: `4918` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `documents_runtime`
* **Test Name**: `DocumentsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `DocumentsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **visit** (Selector: `None`, Value: `/common/documents`)
3. **should_be_visible** (Selector: `documents-screen`, Value: `None`)
4. **should_be_visible** (Selector: `documents-title`, Value: `None`)
5. **should_be_visible** (Selector: `documents-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
