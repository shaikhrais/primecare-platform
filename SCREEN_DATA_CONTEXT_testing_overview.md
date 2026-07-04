# SCREEN DATA CONTEXT: testing_overview

Below are the database records from `governance.db` used to configure and build the **QA Specialist - TestingOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `567`
* **App ID**: `5`
* **Role ID**: `63`
* **Screen Code**: `testing_overview`
* **Screen Name**: `TestingOverviewScreen`
* **Route Path**: `/staff/testing-overview`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/testing_overview_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `63`
* **Role Code**: `qa_specialist`
* **Role Name**: `QA Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable QA Specialist personnel to oversee, audit, and coordinate operations related to testingoverviewscreen.`
* **User Story**: `As a QA Specialist, I want to access the TestingOverviewScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TestingOverviewScreen`
* **Acceptance Criteria**:
- The TestingOverviewScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only QA Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `testing_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `testing_overview-title` (Type: header, Required: 1)
* **primary_content** -> `testing_overview-content` (Type: layout, Required: 1)
* **testingoverview_btn_1** -> `testingoverview-btn-1` (Type: button, Required: 0)
* **testingoverview_content** -> `testingoverview-content` (Type: layout, Required: 0)
* **testingoverview_screen** -> `testingoverview-screen` (Type: layout, Required: 0)
* **testingoverview_btn_5** -> `testingoverview-btn-5` (Type: button, Required: 0)
* **testingoverview_title** -> `testingoverview-title` (Type: header, Required: 0)
* **testingoverview_loading** -> `testingoverview-loading` (Type: loading, Required: 0)
* **testingoverview_btn_4** -> `testingoverview-btn-4` (Type: button, Required: 0)
* **testingoverview_btn_2** -> `testingoverview-btn-2` (Type: button, Required: 0)
* **testingoverview_btn_3** -> `testingoverview-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `491` (Required: 1)
* Component ID: `1025` (Required: 1)
* Component ID: `1559` (Required: 1)
* Component ID: `5959` (Required: 1)
* Component ID: `5960` (Required: 1)
* Component ID: `5961` (Required: 1)
* Component ID: `5962` (Required: 1)
* Component ID: `5963` (Required: 1)
* Component ID: `5964` (Required: 1)
* Component ID: `5965` (Required: 1)
* Component ID: `5966` (Required: 1)
* Component ID: `5967` (Required: 1)
* Component ID: `5968` (Required: 1)

## 7. API / Data Mapping
* API ID: `4914` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `testing_overview_runtime`
* **Test Name**: `TestingOverviewScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TestingOverviewScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **visit** (Selector: `None`, Value: `/staff/testing-overview`)
3. **should_be_visible** (Selector: `testing_overview-screen`, Value: `None`)
4. **should_be_visible** (Selector: `testing_overview-title`, Value: `None`)
5. **should_be_visible** (Selector: `testing_overview-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
