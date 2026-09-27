# SCREEN DATA CONTEXT: competitor_analysis_board

Below are the database records from `governance.db` used to configure and build the **Guest - CompetitorAnalysisBoardScreen** screen.

---

## 1. Screen Record
* **ID**: `974`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `competitor_analysis_board`
* **Screen Name**: `CompetitorAnalysisBoardScreen`
* **Route Path**: `/generated/competitor-analysis-board`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/marketing/competitor_analysis_board.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to competitor analysis board.`
* **User Story**: `As a Guest, I want to access the Competitor Analysis Board within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Competitor Analysis Board`
* **Acceptance Criteria**:
- The Competitor Analysis Board route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `competitor_analysis_board-screen` (Type: layout, Required: 1)
* **page_title** -> `competitor_analysis_board-title` (Type: header, Required: 1)
* **primary_content** -> `competitor_analysis_board-content` (Type: layout, Required: 1)
* **competitor_analysis_board_iconbutton_button_1** -> `competitor_analysis_board_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8311` (Required: 1)
* Component ID: `8312` (Required: 1)
* Component ID: `8313` (Required: 1)
* Component ID: `8314` (Required: 1)
* Component ID: `8315` (Required: 1)

## 7. API / Data Mapping
* API ID: `5414` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `competitor_analysis_board_runtime`
* **Test Name**: `Competitor Analysis Board Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Competitor Analysis Board`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/competitor-analysis-board`)
3. **should_be_visible** (Selector: `competitor_analysis_board-screen`, Value: `None`)
4. **should_be_visible** (Selector: `competitor_analysis_board-title`, Value: `None`)
5. **should_be_visible** (Selector: `competitor_analysis_board-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
