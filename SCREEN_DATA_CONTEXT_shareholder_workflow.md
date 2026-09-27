# SCREEN DATA CONTEXT: shareholder_workflow

Below are the database records from `governance.db` used to configure and build the **Shareholder - ShareholderWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `182`
* **App ID**: `1`
* **Role ID**: `30`
* **Screen Code**: `shareholder_workflow`
* **Screen Name**: `ShareholderWorkflowScreen`
* **Route Path**: `/executive/shareholder-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/shareholder_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `30`
* **Role Code**: `shareholder`
* **Role Name**: `Shareholder`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Shareholder personnel to oversee, audit, and coordinate operations related to shareholderworkflowscreen.`
* **User Story**: `As a Shareholder, I want to access the ShareholderWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ShareholderWorkflowScreen`
* **Acceptance Criteria**:
- The ShareholderWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shareholder access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `shareholder_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `shareholder_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `shareholder_workflow-content` (Type: layout, Required: 1)
* **shareholderworkflow_content** -> `shareholderworkflow-content` (Type: layout, Required: 0)
* **shareholderworkflow_btn_3** -> `shareholderworkflow-btn-3` (Type: button, Required: 0)
* **shareholderworkflow_btn_1** -> `shareholderworkflow-btn-1` (Type: button, Required: 0)
* **shareholderworkflow_btn_2** -> `shareholderworkflow-btn-2` (Type: button, Required: 0)
* **shareholderworkflow_screen** -> `shareholderworkflow-screen` (Type: layout, Required: 0)
* **shareholderworkflow_title** -> `shareholderworkflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `190` (Required: 1)
* Component ID: `724` (Required: 1)
* Component ID: `1258` (Required: 1)
* Component ID: `3192` (Required: 1)
* Component ID: `3193` (Required: 1)
* Component ID: `3194` (Required: 1)
* Component ID: `3195` (Required: 1)
* Component ID: `3196` (Required: 1)

## 7. API / Data Mapping
* API ID: `4471` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `shareholder_workflow_runtime`
* **Test Name**: `ShareholderWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ShareholderWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `shareholder`)
2. **visit** (Selector: `None`, Value: `/executive/shareholder-workflow`)
3. **should_be_visible** (Selector: `shareholder_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `shareholder_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `shareholder_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
