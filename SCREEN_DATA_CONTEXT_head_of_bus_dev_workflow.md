# SCREEN DATA CONTEXT: head_of_bus_dev_workflow

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - HeadOfBusDevWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `203`
* **App ID**: `1`
* **Role ID**: `37`
* **Screen Code**: `head_of_bus_dev_workflow`
* **Screen Name**: `HeadOfBusDevWorkflowScreen`
* **Route Path**: `/management/head-of-bus-dev-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/head_of_bus_dev_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `37`
* **Role Code**: `bus_dev`
* **Role Name**: `Head of Business Development`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to headofbusdevworkflowscreen.`
* **User Story**: `As a Head of Business Development, I want to access the HeadOfBusDevWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HeadOfBusDevWorkflowScreen`
* **Acceptance Criteria**:
- The HeadOfBusDevWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_bus_dev_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_bus_dev_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_bus_dev_workflow-content` (Type: layout, Required: 1)
* **headofbusdevworkflow_screen** -> `headofbusdevworkflow-screen` (Type: layout, Required: 0)
* **headofbusdevworkflow_title** -> `headofbusdevworkflow-title` (Type: header, Required: 0)
* **headofbusdevworkflow_content** -> `headofbusdevworkflow-content` (Type: layout, Required: 0)
* **headofbusdevworkflow_btn_2** -> `headofbusdevworkflow-btn-2` (Type: button, Required: 0)
* **headofbusdevworkflow_btn_1** -> `headofbusdevworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `211` (Required: 1)
* Component ID: `745` (Required: 1)
* Component ID: `1279` (Required: 1)
* Component ID: `3383` (Required: 1)
* Component ID: `3384` (Required: 1)
* Component ID: `3385` (Required: 1)
* Component ID: `3386` (Required: 1)
* Component ID: `3387` (Required: 1)
* Component ID: `3388` (Required: 1)
* Component ID: `3389` (Required: 1)
* Component ID: `3390` (Required: 1)
* Component ID: `3391` (Required: 1)
* Component ID: `3392` (Required: 1)

## 7. API / Data Mapping
* API ID: `4492` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_bus_dev_workflow_runtime`
* **Test Name**: `HeadOfBusDevWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Head Of Bus Dev Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Head Of Bus Dev Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Head Of Bus Dev Workflow`)
5. **check_url** (Selector: `None`, Value: `/management/head-of-bus-dev-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
