# SCREEN DATA CONTEXT: board_of_directors_summary

Below are the database records from `governance.db` used to configure and build the **Guest - BoardOfDirectorsSummaryScreen** screen.

---

## 1. Screen Record
* **ID**: `937`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `board_of_directors_summary`
* **Screen Name**: `BoardOfDirectorsSummaryScreen`
* **Route Path**: `/generated/board-of-directors-summary`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/analytics/board_of_directors_summary.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to board of directors summary.`
* **User Story**: `As a Guest, I want to access the Board Of Directors Summary within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Board Of Directors Summary`
* **Acceptance Criteria**:
- The Board Of Directors Summary route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `board_of_directors_summary-screen` (Type: layout, Required: 1)
* **page_title** -> `board_of_directors_summary-title` (Type: header, Required: 1)
* **primary_content** -> `board_of_directors_summary-content` (Type: layout, Required: 1)
* **board_of_directors_summary_iconbutton_button_1** -> `board_of_directors_summary_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8134` (Required: 1)
* Component ID: `8135` (Required: 1)
* Component ID: `8136` (Required: 1)

## 7. API / Data Mapping
* API ID: `5373` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `board_of_directors_summary_runtime`
* **Test Name**: `Board Of Directors Summary Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Board Of Directors Summary`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Board Of Directors Summary`)
4. **click_sidebar_link** (Selector: `None`, Value: `Board Of Directors Summary`)
5. **check_url** (Selector: `None`, Value: `/generated/board-of-directors-summary`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
