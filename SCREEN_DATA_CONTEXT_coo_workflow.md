# SCREEN DATA CONTEXT: coo_workflow

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - CooWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `161`
* **App ID**: `1`
* **Role ID**: `23`
* **Screen Code**: `coo_workflow`
* **Screen Name**: `CooWorkflowScreen`
* **Route Path**: `/executive/coo-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/coo_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `23`
* **Role Code**: `coo`
* **Role Name**: `Chief Operating Officer (COO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to cooworkflowscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the CooWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CooWorkflowScreen`
* **Acceptance Criteria**:
- The CooWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `coo_workflow-content` (Type: layout, Required: 1)
* **cooworkflow_btn_2** -> `cooworkflow-btn-2` (Type: button, Required: 0)
* **cooworkflow_btn_1** -> `cooworkflow-btn-1` (Type: button, Required: 0)
* **cooworkflow_screen** -> `cooworkflow-screen` (Type: layout, Required: 0)
* **cooworkflow_title** -> `cooworkflow-title` (Type: header, Required: 0)
* **cooworkflow_content** -> `cooworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `169` (Required: 1)
* Component ID: `703` (Required: 1)
* Component ID: `1237` (Required: 1)
* Component ID: `2990` (Required: 1)
* Component ID: `2991` (Required: 1)
* Component ID: `2992` (Required: 1)
* Component ID: `2993` (Required: 1)
* Component ID: `2994` (Required: 1)
* Component ID: `2995` (Required: 1)
* Component ID: `2996` (Required: 1)
* Component ID: `2997` (Required: 1)
* Component ID: `2998` (Required: 1)
* Component ID: `2999` (Required: 1)

## 7. API / Data Mapping
* API ID: `4450` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_workflow_runtime`
* **Test Name**: `CooWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CooWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/executive/coo-workflow`)
3. **should_be_visible** (Selector: `coo_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
