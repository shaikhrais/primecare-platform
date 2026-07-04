# SCREEN DATA CONTEXT: medical_library_access_portal

Below are the database records from `governance.db` used to configure and build the **Guest - MedicalLibraryAccessPortalScreen** screen.

---

## 1. Screen Record
* **ID**: `955`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `medical_library_access_portal`
* **Screen Name**: `MedicalLibraryAccessPortalScreen`
* **Route Path**: `/generated/medical-library-access-portal`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/education/medical_library_access_portal.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to medical library access portal.`
* **User Story**: `As a Guest, I want to access the Medical Library Access Portal within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Medical Library Access Portal`
* **Acceptance Criteria**:
- The Medical Library Access Portal route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `medical_library_access_portal-screen` (Type: layout, Required: 1)
* **page_title** -> `medical_library_access_portal-title` (Type: header, Required: 1)
* **primary_content** -> `medical_library_access_portal-content` (Type: layout, Required: 1)
* **medical_library_access_portal_iconbutton_button_1** -> `medical_library_access_portal_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8206` (Required: 1)
* Component ID: `8207` (Required: 1)
* Component ID: `8208` (Required: 1)
* Component ID: `8209` (Required: 1)
* Component ID: `8210` (Required: 1)

## 7. API / Data Mapping
* API ID: `5393` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `medical_library_access_portal_runtime`
* **Test Name**: `Medical Library Access Portal Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Medical Library Access Portal`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/medical-library-access-portal`)
3. **should_be_visible** (Selector: `medical_library_access_portal-screen`, Value: `None`)
4. **should_be_visible** (Selector: `medical_library_access_portal-title`, Value: `None`)
5. **should_be_visible** (Selector: `medical_library_access_portal-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
