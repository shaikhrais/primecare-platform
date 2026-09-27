# SCREEN DATA CONTEXT: touchpoint_analyzer

Below are the database records from `governance.db` used to configure and build the **Guest - TouchpointAnalyzerScreen** screen.

---

## 1. Screen Record
* **ID**: `934`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `touchpoint_analyzer`
* **Screen Name**: `TouchpointAnalyzerScreen`
* **Route Path**: `/generated/touchpoint-analyzer`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/touchpoint_analyzer_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to touchpoint analyzer.`
* **User Story**: `As a Guest, I want to access the Touchpoint Analyzer within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Touchpoint Analyzer`
* **Acceptance Criteria**:
- The Touchpoint Analyzer route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `touchpoint_analyzer-screen` (Type: layout, Required: 1)
* **page_title** -> `touchpoint_analyzer-title` (Type: header, Required: 1)
* **primary_content** -> `touchpoint_analyzer-content` (Type: layout, Required: 1)
* **touchpoint_analyzer_screen_iconbutton_button_1** -> `touchpoint_analyzer_screen_iconbutton_button_1` (Type: button, Required: 0)
* **touchpoint_analyzer_screen_textbutton_button_1** -> `touchpoint_analyzer_screen_textbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8119` (Required: 1)
* Component ID: `8120` (Required: 1)
* Component ID: `8121` (Required: 1)
* Component ID: `8122` (Required: 1)
* Component ID: `8123` (Required: 1)

## 7. API / Data Mapping
* API ID: `5366` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `touchpoint_analyzer_runtime`
* **Test Name**: `Touchpoint Analyzer Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Touchpoint Analyzer`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/touchpoint-analyzer`)
3. **should_be_visible** (Selector: `touchpoint_analyzer-screen`, Value: `None`)
4. **should_be_visible** (Selector: `touchpoint_analyzer-title`, Value: `None`)
5. **should_be_visible** (Selector: `touchpoint_analyzer-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
