# SCREEN DATA CONTEXT: client_care_team

Below are the database records from `governance.db` used to configure and build the **Guest - ClientCareTeamScreen** screen.

---

## 1. Screen Record
* **ID**: `661`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `client_care_team`
* **Screen Name**: `ClientCareTeamScreen`
* **Route Path**: `/generated/client-care-team`
* **Actual File Path**: `apps/primecare_client/lib/features/generated_screens/client_care_team_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to client care team.`
* **User Story**: `As a Guest, I want to access the Client Care Team within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Client Care Team`
* **Acceptance Criteria**:
- The Client Care Team route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `client_care_team-screen` (Type: layout, Required: 1)
* **page_title** -> `client_care_team-title` (Type: header, Required: 1)
* **primary_content** -> `client_care_team-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6631` (Required: 1)
* Component ID: `6632` (Required: 1)
* Component ID: `6633` (Required: 1)
* Component ID: `6634` (Required: 1)
* Component ID: `6635` (Required: 1)
* Component ID: `6636` (Required: 1)
* Component ID: `6637` (Required: 1)

## 7. API / Data Mapping
* API ID: `5021` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `client_care_team_runtime`
* **Test Name**: `Client Care Team Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Client Care Team`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/client-care-team`)
3. **should_be_visible** (Selector: `client_care_team-screen`, Value: `None`)
4. **should_be_visible** (Selector: `client_care_team-title`, Value: `None`)
5. **should_be_visible** (Selector: `client_care_team-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
