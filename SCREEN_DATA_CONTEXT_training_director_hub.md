# SCREEN DATA CONTEXT: training_director_hub

Below are the database records from `governance.db` used to configure and build the **Guest - TrainingDirectorHubScreen** screen.

---

## 1. Screen Record
* **ID**: `767`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `training_director_hub`
* **Screen Name**: `TrainingDirectorHubScreen`
* **Route Path**: `/offices/corporate/roles/training_director/hub`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/training_director_hub_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to training director hub.`
* **User Story**: `As a Guest, I want to access the Training Director Hub within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Training Director Hub`
* **Acceptance Criteria**:
- The Training Director Hub route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_director_hub-screen` (Type: layout, Required: 1)
* **page_title** -> `training_director_hub-title` (Type: header, Required: 1)
* **primary_content** -> `training_director_hub-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7214` (Required: 1)
* Component ID: `7215` (Required: 1)
* Component ID: `7216` (Required: 1)
* Component ID: `7217` (Required: 1)
* Component ID: `7218` (Required: 1)
* Component ID: `7219` (Required: 1)

## 7. API / Data Mapping
* API ID: `5157` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_director_hub_runtime`
* **Test Name**: `Training Director Hub Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Director Hub`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/training_director/hub`)
3. **should_be_visible** (Selector: `training_director_hub-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_director_hub-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_director_hub-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
