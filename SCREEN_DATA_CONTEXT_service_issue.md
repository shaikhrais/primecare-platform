# SCREEN DATA CONTEXT: service_issue

Below are the database records from `governance.db` used to configure and build the **Operations Manager - ServiceIssueScreen** screen.

---

## 1. Screen Record
* **ID**: `511`
* **App ID**: `5`
* **Role ID**: `40`
* **Screen Code**: `service_issue`
* **Screen Name**: `ServiceIssueScreen`
* **Route Path**: `/management/service-issue`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/service_issue_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `40`
* **Role Code**: `ops_manager`
* **Role Name**: `Operations Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Operations Manager personnel to oversee, audit, and coordinate operations related to serviceissuescreen.`
* **User Story**: `As a Operations Manager, I want to access the ServiceIssueScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ServiceIssueScreen`
* **Acceptance Criteria**:
- The ServiceIssueScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Operations Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `service_issue-screen` (Type: layout, Required: 1)
* **page_title** -> `service_issue-title` (Type: header, Required: 1)
* **primary_content** -> `service_issue-content` (Type: layout, Required: 1)
* **serviceissue_btn_3** -> `serviceissue-btn-3` (Type: button, Required: 0)
* **serviceissue_btn_1** -> `serviceissue-btn-1` (Type: button, Required: 0)
* **serviceissue_screen** -> `serviceissue-screen` (Type: layout, Required: 0)
* **serviceissue_title** -> `serviceissue-title` (Type: header, Required: 0)
* **serviceissue_loading** -> `serviceissue-loading` (Type: loading, Required: 0)
* **serviceissue_content** -> `serviceissue-content` (Type: layout, Required: 0)
* **serviceissue_btn_2** -> `serviceissue-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `440` (Required: 1)
* Component ID: `974` (Required: 1)
* Component ID: `1508` (Required: 1)
* Component ID: `5489` (Required: 1)
* Component ID: `5490` (Required: 1)
* Component ID: `5491` (Required: 1)
* Component ID: `5492` (Required: 1)
* Component ID: `5493` (Required: 1)
* Component ID: `5494` (Required: 1)
* Component ID: `5495` (Required: 1)
* Component ID: `5496` (Required: 1)
* Component ID: `5497` (Required: 1)

## 7. API / Data Mapping
* API ID: `4827` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `service_issue_runtime`
* **Test Name**: `ServiceIssueScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ServiceIssueScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ops_manager`)
2. **visit** (Selector: `None`, Value: `/management/service-issue`)
3. **should_be_visible** (Selector: `service_issue-screen`, Value: `None`)
4. **should_be_visible** (Selector: `service_issue-title`, Value: `None`)
5. **should_be_visible** (Selector: `service_issue-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
