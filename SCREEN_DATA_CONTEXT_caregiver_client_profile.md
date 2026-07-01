# SCREEN DATA CONTEXT: caregiver_client_profile

Below are the database records from `governance.db` used to configure and build the **Caregiver - CaregiverClientProfileScreen** screen.

---

## 1. Screen Record
* **ID**: `279`
* **App ID**: `5`
* **Role ID**: `12`
* **Screen Code**: `caregiver_client_profile`
* **Screen Name**: `CaregiverClientProfileScreen`
* **Route Path**: `/offices/clinical/roles/caregiver/client-profile`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/caregiver_client_profile_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `12`
* **Role Code**: `caregiver`
* **Role Name**: `Caregiver`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Caregiver personnel to oversee, audit, and coordinate operations related to caregiverclientprofilescreen.`
* **User Story**: `As a Caregiver, I want to access the CaregiverClientProfileScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CaregiverClientProfileScreen`
* **Acceptance Criteria**:
- The CaregiverClientProfileScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Caregiver access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `caregiver_client_profile-screen` (Type: layout, Required: 1)
* **page_title** -> `caregiver_client_profile-title` (Type: header, Required: 1)
* **primary_content** -> `caregiver_client_profile-content` (Type: layout, Required: 1)
* **caregiverclientprofile_btn_1** -> `caregiverclientprofile-btn-1` (Type: button, Required: 0)
* **caregiverclientprofile_screen** -> `caregiverclientprofile-screen` (Type: layout, Required: 0)
* **caregiverclientprofile_btn_2** -> `caregiverclientprofile-btn-2` (Type: button, Required: 0)
* **caregiverclientprofile_title** -> `caregiverclientprofile-title` (Type: header, Required: 0)
* **caregiverclientprofile_btn_3** -> `caregiverclientprofile-btn-3` (Type: button, Required: 0)
* **caregiverclientprofile_content** -> `caregiverclientprofile-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `287` (Required: 1)
* Component ID: `821` (Required: 1)
* Component ID: `1355` (Required: 1)
* Component ID: `4070` (Required: 1)
* Component ID: `4071` (Required: 1)
* Component ID: `4072` (Required: 1)
* Component ID: `4073` (Required: 1)
* Component ID: `4074` (Required: 1)
* Component ID: `4075` (Required: 1)
* Component ID: `4076` (Required: 1)

## 7. API / Data Mapping
* API ID: `4600` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `caregiver_client_profile_runtime`
* **Test Name**: `CaregiverClientProfileScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Caregiver Client Profile`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `caregiver`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Caregiver Client Profile`)
4. **click_sidebar_link** (Selector: `None`, Value: `Caregiver Client Profile`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/caregiver/client-profile`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
