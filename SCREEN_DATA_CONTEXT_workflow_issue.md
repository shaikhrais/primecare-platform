# SCREEN DATA CONTEXT: workflow_issue

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - WorkflowIssueScreen** screen.

---

## 1. Screen Record
* **ID**: `472`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `workflow_issue`
* **Screen Name**: `WorkflowIssueScreen`
* **Route Path**: `/executive/workflow-issue`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/workflow_issue_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to workflowissuescreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the WorkflowIssueScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `WorkflowIssueScreen`
* **Acceptance Criteria**:
- The WorkflowIssueScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `workflow_issue-screen` (Type: layout, Required: 1)
* **page_title** -> `workflow_issue-title` (Type: header, Required: 1)
* **primary_content** -> `workflow_issue-content` (Type: layout, Required: 1)
* **workflowissue_screen** -> `workflowissue-screen` (Type: layout, Required: 0)
* **workflowissue_btn_2** -> `workflowissue-btn-2` (Type: button, Required: 0)
* **workflowissue_btn_1** -> `workflowissue-btn-1` (Type: button, Required: 0)
* **workflowissue_btn_3** -> `workflowissue-btn-3` (Type: button, Required: 0)
* **workflowissue_content** -> `workflowissue-content` (Type: layout, Required: 0)
* **workflowissue_loading** -> `workflowissue-loading` (Type: loading, Required: 0)
* **workflowissue_title** -> `workflowissue-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `401` (Required: 1)
* Component ID: `935` (Required: 1)
* Component ID: `1469` (Required: 1)
* Component ID: `5103` (Required: 1)
* Component ID: `5104` (Required: 1)
* Component ID: `5105` (Required: 1)
* Component ID: `5106` (Required: 1)
* Component ID: `5107` (Required: 1)
* Component ID: `5108` (Required: 1)
* Component ID: `5109` (Required: 1)
* Component ID: `5110` (Required: 1)
* Component ID: `5111` (Required: 1)
* Component ID: `5112` (Required: 1)

## 7. API / Data Mapping
* API ID: `4787` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `workflow_issue_runtime`
* **Test Name**: `WorkflowIssueScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `WorkflowIssueScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/executive/workflow-issue`)
3. **should_be_visible** (Selector: `workflow_issue-screen`, Value: `None`)
4. **should_be_visible** (Selector: `workflow_issue-title`, Value: `None`)
5. **should_be_visible** (Selector: `workflow_issue-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
