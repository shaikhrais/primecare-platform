# SCREEN DATA CONTEXT: psw_documents

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - DocumentsScreen** screen.

---

## 1. Screen Record
* **ID**: `351`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `psw_documents`
* **Screen Name**: `DocumentsScreen`
* **Route Path**: `/offices/clinical/roles/psw/documents`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_documents_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswdocumentsscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswDocumentsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswDocumentsScreen`
* **Acceptance Criteria**:
- The PswDocumentsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_documents-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_documents-title` (Type: header, Required: 1)
* **primary_content** -> `psw_documents-content` (Type: layout, Required: 1)
* **pswdocuments_btn_1** -> `pswdocuments-btn-1` (Type: button, Required: 0)
* **pswdocuments_content** -> `pswdocuments-content` (Type: layout, Required: 0)
* **pswdocuments_loading** -> `pswdocuments-loading` (Type: loading, Required: 0)
* **pswdocuments_title** -> `pswdocuments-title` (Type: header, Required: 0)
* **pswdocuments_screen** -> `pswdocuments-screen` (Type: layout, Required: 0)
* **pswdocuments_btn_2** -> `pswdocuments-btn-2` (Type: button, Required: 0)
* **pswdocuments_btn_3** -> `pswdocuments-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `357` (Required: 1)
* Component ID: `891` (Required: 1)
* Component ID: `1425` (Required: 1)
* Component ID: `4689` (Required: 1)
* Component ID: `4690` (Required: 1)
* Component ID: `4691` (Required: 1)
* Component ID: `4692` (Required: 1)
* Component ID: `4693` (Required: 1)
* Component ID: `4694` (Required: 1)
* Component ID: `4695` (Required: 1)
* Component ID: `4696` (Required: 1)
* Component ID: `4697` (Required: 1)
* Component ID: `4698` (Required: 1)

## 7. API / Data Mapping
* API ID: `4682` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_documents_runtime`
* **Test Name**: `Documents Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Documents`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/documents`)
3. **should_be_visible** (Selector: `psw_documents-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_documents-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_documents-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
