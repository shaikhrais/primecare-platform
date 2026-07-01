# SCREEN DATA CONTEXT: journal_club_discussion_board

Below are the database records from `governance.db` used to configure and build the **Guest - JournalClubDiscussionBoardScreen** screen.

---

## 1. Screen Record
* **ID**: `954`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `journal_club_discussion_board`
* **Screen Name**: `JournalClubDiscussionBoardScreen`
* **Route Path**: `/generated/journal-club-discussion-board`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/education/journal_club_discussion_board.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to journal club discussion board.`
* **User Story**: `As a Guest, I want to access the Journal Club Discussion Board within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Journal Club Discussion Board`
* **Acceptance Criteria**:
- The Journal Club Discussion Board route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `journal_club_discussion_board-screen` (Type: layout, Required: 1)
* **page_title** -> `journal_club_discussion_board-title` (Type: header, Required: 1)
* **primary_content** -> `journal_club_discussion_board-content` (Type: layout, Required: 1)
* **journal_club_discussion_board_textbutton_button_1** -> `journal_club_discussion_board_textbutton_button_1` (Type: button, Required: 0)
* **journal_club_discussion_board_iconbutton_button_1** -> `journal_club_discussion_board_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8202` (Required: 1)
* Component ID: `8203` (Required: 1)
* Component ID: `8204` (Required: 1)
* Component ID: `8205` (Required: 1)

## 7. API / Data Mapping
* API ID: `5392` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `journal_club_discussion_board_runtime`
* **Test Name**: `Journal Club Discussion Board Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Journal Club Discussion Board`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Journal Club Discussion Board`)
4. **click_sidebar_link** (Selector: `None`, Value: `Journal Club Discussion Board`)
5. **check_url** (Selector: `None`, Value: `/generated/journal-club-discussion-board`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
