# SCREEN DATA CONTEXT: physician_workflow

Below are the database records from `governance.db` used to configure and build the **Physician - PhysicianComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `600`
* **App ID**: `1`
* **Role ID**: `9`
* **Screen Code**: `physician_workflow`
* **Screen Name**: `PhysicianComplianceWorkflowScreen`
* **Route Path**: `/clinical/physician-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/physician_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `9`
* **Role Code**: `physician`
* **Role Name**: `Physician`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Physician personnel to oversee, audit, and coordinate operations related to physician compliance workflow.`
* **User Story**: `As a Physician, I want to access the Physician Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Physician Compliance Workflow`
* **Acceptance Criteria**:
- The Physician Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physician access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physician_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `physician_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `physician_workflow-content` (Type: layout, Required: 1)
* **physician compliance workflow_title** -> `physician compliance workflow-title` (Type: header, Required: 0)
* **physician compliance workflow_screen** -> `physician compliance workflow-screen` (Type: layout, Required: 0)
* **physician compliance workflow_btn_2** -> `physician compliance workflow-btn-2` (Type: button, Required: 0)
* **physician compliance workflow_btn_3** -> `physician compliance workflow-btn-3` (Type: button, Required: 0)
* **physician compliance workflow_content** -> `physician compliance workflow-content` (Type: layout, Required: 0)
* **physician compliance workflow_btn_1** -> `physician compliance workflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `524` (Required: 1)
* Component ID: `1058` (Required: 1)
* Component ID: `1592` (Required: 1)
* Component ID: `6247` (Required: 1)
* Component ID: `6248` (Required: 1)
* Component ID: `6249` (Required: 1)
* Component ID: `6250` (Required: 1)
* Component ID: `6251` (Required: 1)
* Component ID: `6252` (Required: 1)
* Component ID: `6253` (Required: 1)
* Component ID: `6254` (Required: 1)
* Component ID: `6255` (Required: 1)
* Component ID: `6256` (Required: 1)

## 7. API / Data Mapping
* API ID: `4949` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physician_workflow_runtime`
* **Test Name**: `Physician Compliance Workflow Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Physician Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physician`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Physician Compliance Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Physician Compliance Workflow`)
5. **check_url** (Selector: `None`, Value: `/clinical/physician-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
