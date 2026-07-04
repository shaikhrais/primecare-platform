# SCREEN DATA CONTEXT: psw_client_profile

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - PswClientProfileScreen** screen.

---

## 1. Screen Record
* **ID**: `345`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `psw_client_profile`
* **Screen Name**: `PswClientProfileScreen`
* **Route Path**: `/offices/clinical/roles/psw/profile`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_client_profile_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswclientprofilescreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswClientProfileScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswClientProfileScreen`
* **Acceptance Criteria**:
- The PswClientProfileScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_client_profile-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_client_profile-title` (Type: header, Required: 1)
* **primary_content** -> `psw_client_profile-content` (Type: layout, Required: 1)
* **pswclientprofile_btn_3** -> `pswclientprofile-btn-3` (Type: button, Required: 0)
* **pswclientprofile_title** -> `pswclientprofile-title` (Type: header, Required: 0)
* **pswclientprofile_content** -> `pswclientprofile-content` (Type: layout, Required: 0)
* **pswclientprofile_loading** -> `pswclientprofile-loading` (Type: loading, Required: 0)
* **pswclientprofile_btn_1** -> `pswclientprofile-btn-1` (Type: button, Required: 0)
* **pswclientprofile_screen** -> `pswclientprofile-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `353` (Required: 1)
* Component ID: `887` (Required: 1)
* Component ID: `1421` (Required: 1)
* Component ID: `4644` (Required: 1)
* Component ID: `4645` (Required: 1)
* Component ID: `4646` (Required: 1)
* Component ID: `4647` (Required: 1)
* Component ID: `4648` (Required: 1)
* Component ID: `4649` (Required: 1)
* Component ID: `4650` (Required: 1)
* Component ID: `4651` (Required: 1)
* Component ID: `4652` (Required: 1)
* Component ID: `4653` (Required: 1)

## 7. API / Data Mapping
* API ID: `4678` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_client_profile_runtime`
* **Test Name**: `Psw Client Profile Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Client Profile`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/profile`)
3. **should_be_visible** (Selector: `psw_client_profile-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_client_profile-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_client_profile-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
