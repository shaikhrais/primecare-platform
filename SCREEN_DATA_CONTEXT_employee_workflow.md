# SCREEN DATA CONTEXT: employee_workflow

Below are the database records from `governance.db` used to configure and build the **Employee - EmployeeComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `618`
* **App ID**: `1`
* **Role ID**: `57`
* **Screen Code**: `employee_workflow`
* **Screen Name**: `EmployeeComplianceWorkflowScreen`
* **Route Path**: `/staff/employee-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/employee_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `57`
* **Role Code**: `employee`
* **Role Name**: `Employee`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Employee personnel to oversee, audit, and coordinate operations related to employee compliance workflow.`
* **User Story**: `As a Employee, I want to access the Employee Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Employee Compliance Workflow`
* **Acceptance Criteria**:
- The Employee Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Employee access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `employee_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `employee_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `employee_workflow-content` (Type: layout, Required: 1)
* **employee compliance workflow_screen** -> `employee compliance workflow-screen` (Type: layout, Required: 0)
* **employee compliance workflow_btn_2** -> `employee compliance workflow-btn-2` (Type: button, Required: 0)
* **employee compliance workflow_btn_1** -> `employee compliance workflow-btn-1` (Type: button, Required: 0)
* **employee compliance workflow_content** -> `employee compliance workflow-content` (Type: layout, Required: 0)
* **employee compliance workflow_btn_3** -> `employee compliance workflow-btn-3` (Type: button, Required: 0)
* **employee compliance workflow_title** -> `employee compliance workflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `542` (Required: 1)
* Component ID: `1076` (Required: 1)
* Component ID: `1610` (Required: 1)
* Component ID: `6399` (Required: 1)
* Component ID: `6400` (Required: 1)
* Component ID: `6401` (Required: 1)
* Component ID: `6402` (Required: 1)
* Component ID: `6403` (Required: 1)

## 7. API / Data Mapping
* API ID: `4971` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `employee_workflow_runtime`
* **Test Name**: `Employee Compliance Workflow Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Employee Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `employee`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Employee Compliance Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Employee Compliance Workflow`)
5. **check_url** (Selector: `None`, Value: `/staff/employee-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
