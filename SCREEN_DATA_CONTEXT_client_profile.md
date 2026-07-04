# SCREEN DATA CONTEXT: client_profile

Below are the database records from `governance.db` used to configure and build the **Guest - ClientProfileScreen** screen.

---

## 1. Screen Record
* **ID**: `665`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `client_profile`
* **Screen Name**: `ClientProfileScreen`
* **Route Path**: `/clinic/client-profile`
* **Actual File Path**: `apps/primecare_client/lib/features/generated_screens/client_profile_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to client profile.`
* **User Story**: `As a Guest, I want to access the Client Profile within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Client Profile`
* **Acceptance Criteria**:
- The Client Profile route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `client_profile-screen` (Type: layout, Required: 1)
* **page_title** -> `client_profile-title` (Type: header, Required: 1)
* **primary_content** -> `client_profile-content` (Type: layout, Required: 1)
* **clientprofilescreen_screen** -> `clientprofilescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6653` (Required: 1)
* Component ID: `6654` (Required: 1)
* Component ID: `6655` (Required: 1)
* Component ID: `6656` (Required: 1)
* Component ID: `6657` (Required: 1)

## 7. API / Data Mapping
* API ID: `5025` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `client_profile_runtime`
* **Test Name**: `Client Profile Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Client Profile`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/clinic/client-profile`)
3. **should_be_visible** (Selector: `client_profile-screen`, Value: `None`)
4. **should_be_visible** (Selector: `client_profile-title`, Value: `None`)
5. **should_be_visible** (Selector: `client_profile-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
