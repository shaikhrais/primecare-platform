# SCREEN DATA CONTEXT: gamification_profile

Below are the database records from `governance.db` used to configure and build the **Guest - GamificationProfileScreen** screen.

---

## 1. Screen Record
* **ID**: `983`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `gamification_profile`
* **Screen Name**: `GamificationProfileScreen`
* **Route Path**: `/generated/gamification-profile`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/operations/gamification_profile_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to gamification profile.`
* **User Story**: `As a Guest, I want to access the Gamification Profile within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Gamification Profile`
* **Acceptance Criteria**:
- The Gamification Profile route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `gamification_profile-screen` (Type: layout, Required: 1)
* **page_title** -> `gamification_profile-title` (Type: header, Required: 1)
* **primary_content** -> `gamification_profile-content` (Type: layout, Required: 1)
* **gamification_profile_screen_textfield_input_1** -> `gamification_profile_screen_textfield_input_1` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8355` (Required: 1)
* Component ID: `8356` (Required: 1)
* Component ID: `8357` (Required: 1)
* Component ID: `8358` (Required: 1)
* Component ID: `8359` (Required: 1)

## 7. API / Data Mapping
* API ID: `5425` (Required: 1)
* API ID: `5426` (Required: 1)
* API ID: `5427` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `gamification_profile_runtime`
* **Test Name**: `Gamification Profile Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Gamification Profile`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/gamification-profile`)
3. **should_be_visible** (Selector: `gamification_profile-screen`, Value: `None`)
4. **should_be_visible** (Selector: `gamification_profile-title`, Value: `None`)
5. **should_be_visible** (Selector: `gamification_profile-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
