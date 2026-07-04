# SCREEN DATA CONTEXT: psw_profile

Below are the database records from `governance.db` used to configure and build the **Guest - PswProfileScreen** screen.

---

## 1. Screen Record
* **ID**: `689`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_profile`
* **Screen Name**: `PswProfileScreen`
* **Route Path**: `/generated/psw-profile`
* **Actual File Path**: `apps/primecare_clinic/lib/features/psw/screens/psw_profile_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw profile.`
* **User Story**: `As a Guest, I want to access the Psw Profile within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Profile`
* **Acceptance Criteria**:
- The Psw Profile route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_profile-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_profile-title` (Type: header, Required: 1)
* **primary_content** -> `psw_profile-content` (Type: layout, Required: 1)
* **pswprofile_content** -> `pswprofile-content` (Type: layout, Required: 0)
* **pswprofile_btn_save** -> `pswprofile-btn-save` (Type: button, Required: 0)
* **pswprofile_btn_edit** -> `pswprofile-btn-edit` (Type: button, Required: 0)
* **pswprofile_btn_update_password** -> `pswprofile-btn-update-password` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `6786` (Required: 1)
* Component ID: `6787` (Required: 1)
* Component ID: `6788` (Required: 1)
* Component ID: `6789` (Required: 1)
* Component ID: `6790` (Required: 1)

## 7. API / Data Mapping
* API ID: `5055` (Required: 1)
* API ID: `5056` (Required: 1)
* API ID: `5057` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_profile_runtime`
* **Test Name**: `Psw Profile Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Profile`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/psw-profile`)
3. **should_be_visible** (Selector: `psw_profile-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_profile-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_profile-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
