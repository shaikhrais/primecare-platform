# SCREEN DATA CONTEXT: system_workflow

Below are the database records from `governance.db` used to configure and build the **System Verification Officer - SystemWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `149`
* **App ID**: `1`
* **Role ID**: `18`
* **Screen Code**: `system_workflow`
* **Screen Name**: `SystemWorkflowScreen`
* **Route Path**: `/common/system-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/system_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `18`
* **Role Code**: `system_verification`
* **Role Name**: `System Verification Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable System Verification Officer personnel to oversee, audit, and coordinate operations related to systemworkflowscreen.`
* **User Story**: `As a System Verification Officer, I want to access the SystemWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SystemWorkflowScreen`
* **Acceptance Criteria**:
- The SystemWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only System Verification Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `system_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `system_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `system_workflow-content` (Type: layout, Required: 1)
* **systemworkflow_btn_2** -> `systemworkflow-btn-2` (Type: button, Required: 0)
* **systemworkflow_title** -> `systemworkflow-title` (Type: header, Required: 0)
* **systemworkflow_content** -> `systemworkflow-content` (Type: layout, Required: 0)
* **systemworkflow_btn_1** -> `systemworkflow-btn-1` (Type: button, Required: 0)
* **systemworkflow_screen** -> `systemworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `157` (Required: 1)
* Component ID: `691` (Required: 1)
* Component ID: `1225` (Required: 1)
* Component ID: `2880` (Required: 1)
* Component ID: `2881` (Required: 1)
* Component ID: `2882` (Required: 1)
* Component ID: `2883` (Required: 1)
* Component ID: `2884` (Required: 1)
* Component ID: `2885` (Required: 1)
* Component ID: `2886` (Required: 1)
* Component ID: `2887` (Required: 1)
* Component ID: `2888` (Required: 1)
* Component ID: `2889` (Required: 1)

## 7. API / Data Mapping
* API ID: `4432` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `system_workflow_runtime`
* **Test Name**: `SystemWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SystemWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `system_verification`)
2. **visit** (Selector: `None`, Value: `/common/system-workflow`)
3. **should_be_visible** (Selector: `system_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `system_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `system_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
