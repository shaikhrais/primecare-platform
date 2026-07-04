# SCREEN DATA CONTEXT: family_profile

Below are the database records from `governance.db` used to configure and build the **Guest - FamilyProfileScreen** screen.

---

## 1. Screen Record
* **ID**: `659`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `family_profile`
* **Screen Name**: `FamilyProfileScreen`
* **Route Path**: `/offices/client/roles/family_member/profile`
* **Actual File Path**: `apps/primecare_client/lib/features/family/screens/family_profile_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to family profile.`
* **User Story**: `As a Guest, I want to access the Family Profile within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Family Profile`
* **Acceptance Criteria**:
- The Family Profile route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `family_profile-screen` (Type: layout, Required: 1)
* **page_title** -> `family_profile-title` (Type: header, Required: 1)
* **primary_content** -> `family_profile-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6623` (Required: 1)
* Component ID: `6624` (Required: 1)
* Component ID: `6625` (Required: 1)
* Component ID: `6626` (Required: 1)

## 7. API / Data Mapping
* API ID: `5019` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `family_profile_runtime`
* **Test Name**: `Family Profile Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Family Profile`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/client/roles/family_member/profile`)
3. **should_be_visible** (Selector: `family_profile-screen`, Value: `None`)
4. **should_be_visible** (Selector: `family_profile-title`, Value: `None`)
5. **should_be_visible** (Selector: `family_profile-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
