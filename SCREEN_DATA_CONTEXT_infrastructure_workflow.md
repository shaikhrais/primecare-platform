# SCREEN DATA CONTEXT: infrastructure_workflow

Below are the database records from `governance.db` used to configure and build the **Infrastructure Auditor - InfrastructureWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `118`
* **App ID**: `1`
* **Role ID**: `17`
* **Screen Code**: `infrastructure_workflow`
* **Screen Name**: `InfrastructureWorkflowScreen`
* **Route Path**: `/common/infrastructure-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/infrastructure_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `17`
* **Role Code**: `infrastructure`
* **Role Name**: `Infrastructure Auditor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Infrastructure Auditor personnel to oversee, audit, and coordinate operations related to infrastructureworkflowscreen.`
* **User Story**: `As a Infrastructure Auditor, I want to access the InfrastructureWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `InfrastructureWorkflowScreen`
* **Acceptance Criteria**:
- The InfrastructureWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Infrastructure Auditor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `infrastructure_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `infrastructure_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `infrastructure_workflow-content` (Type: layout, Required: 1)
* **infrastructureworkflow_btn_1** -> `infrastructureworkflow-btn-1` (Type: button, Required: 0)
* **infrastructureworkflow_title** -> `infrastructureworkflow-title` (Type: header, Required: 0)
* **infrastructureworkflow_btn_3** -> `infrastructureworkflow-btn-3` (Type: button, Required: 0)
* **infrastructureworkflow_loading** -> `infrastructureworkflow-loading` (Type: loading, Required: 0)
* **infrastructureworkflow_content** -> `infrastructureworkflow-content` (Type: layout, Required: 0)
* **infrastructureworkflow_btn_2** -> `infrastructureworkflow-btn-2` (Type: button, Required: 0)
* **infrastructureworkflow_screen** -> `infrastructureworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `126` (Required: 1)
* Component ID: `660` (Required: 1)
* Component ID: `1194` (Required: 1)
* Component ID: `2608` (Required: 1)
* Component ID: `2609` (Required: 1)
* Component ID: `2610` (Required: 1)
* Component ID: `2611` (Required: 1)
* Component ID: `2612` (Required: 1)
* Component ID: `2613` (Required: 1)
* Component ID: `2614` (Required: 1)
* Component ID: `2615` (Required: 1)
* Component ID: `2616` (Required: 1)
* Component ID: `2617` (Required: 1)

## 7. API / Data Mapping
* API ID: `4395` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `infrastructure_workflow_runtime`
* **Test Name**: `InfrastructureWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `InfrastructureWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `infrastructure`)
2. **visit** (Selector: `None`, Value: `/common/infrastructure-workflow`)
3. **should_be_visible** (Selector: `infrastructure_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `infrastructure_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `infrastructure_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
