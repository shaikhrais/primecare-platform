# SCREEN DATA CONTEXT: coo_workflow_issues

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - CooWorkflowIssuesScreen** screen.

---

## 1. Screen Record
* **ID**: `308`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `coo_workflow_issues`
* **Screen Name**: `CooWorkflowIssuesScreen`
* **Route Path**: `/executive/coo-workflow-issues`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/coo_workflow_issues_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `23`
* **Role Code**: `coo`
* **Role Name**: `Chief Operating Officer (COO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to cooworkflowissuesscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the CooWorkflowIssuesScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CooWorkflowIssuesScreen`
* **Acceptance Criteria**:
- The CooWorkflowIssuesScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_workflow_issues-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_workflow_issues-title` (Type: header, Required: 1)
* **primary_content** -> `coo_workflow_issues-content` (Type: layout, Required: 1)
* **cooworkflowissues_screen** -> `cooworkflowissues-screen` (Type: layout, Required: 0)
* **cooworkflowissues_btn_3** -> `cooworkflowissues-btn-3` (Type: button, Required: 0)
* **cooworkflowissues_btn_1** -> `cooworkflowissues-btn-1` (Type: button, Required: 0)
* **cooworkflowissues_btn_2** -> `cooworkflowissues-btn-2` (Type: button, Required: 0)
* **cooworkflowissues_loading** -> `cooworkflowissues-loading` (Type: loading, Required: 0)
* **cooworkflowissues_title** -> `cooworkflowissues-title` (Type: header, Required: 0)
* **cooworkflowissues_content** -> `cooworkflowissues-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `316` (Required: 1)
* Component ID: `850` (Required: 1)
* Component ID: `1384` (Required: 1)
* Component ID: `4345` (Required: 1)
* Component ID: `4346` (Required: 1)
* Component ID: `4347` (Required: 1)
* Component ID: `4348` (Required: 1)
* Component ID: `4349` (Required: 1)
* Component ID: `4350` (Required: 1)
* Component ID: `4351` (Required: 1)
* Component ID: `4352` (Required: 1)
* Component ID: `4353` (Required: 1)
* Component ID: `4354` (Required: 1)

## 7. API / Data Mapping
* API ID: `4637` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_workflow_issues_runtime`
* **Test Name**: `CooWorkflowIssuesScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CooWorkflowIssuesScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/executive/coo-workflow-issues`)
3. **should_be_visible** (Selector: `coo_workflow_issues-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_workflow_issues-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_workflow_issues-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
