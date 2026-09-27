# SCREEN DATA CONTEXT: family_member_profile

Below are the database records from `governance.db` used to configure and build the **Guest - FamilyMemberProfileScreen** screen.

---

## 1. Screen Record
* **ID**: `671`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `family_member_profile`
* **Screen Name**: `FamilyMemberProfileScreen`
* **Route Path**: `/generated/family-member-profile`
* **Actual File Path**: `apps/primecare_client/lib/features/generated_screens/family_member_profile_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to family member profile.`
* **User Story**: `As a Guest, I want to access the Family Member Profile within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Family Member Profile`
* **Acceptance Criteria**:
- The Family Member Profile route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `family_member_profile-screen` (Type: layout, Required: 1)
* **page_title** -> `family_member_profile-title` (Type: header, Required: 1)
* **primary_content** -> `family_member_profile-content` (Type: layout, Required: 1)
* **familymemberprofilescreen_screen** -> `familymemberprofilescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6683` (Required: 1)
* Component ID: `6684` (Required: 1)
* Component ID: `6685` (Required: 1)
* Component ID: `6686` (Required: 1)
* Component ID: `6687` (Required: 1)
* Component ID: `6688` (Required: 1)
* Component ID: `6689` (Required: 1)
* Component ID: `6690` (Required: 1)

## 7. API / Data Mapping
* API ID: `5033` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `family_member_profile_runtime`
* **Test Name**: `Family Member Profile Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Family Member Profile`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/family-member-profile`)
3. **should_be_visible** (Selector: `family_member_profile-screen`, Value: `None`)
4. **should_be_visible** (Selector: `family_member_profile-title`, Value: `None`)
5. **should_be_visible** (Selector: `family_member_profile-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
