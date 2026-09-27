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
* **Stage/Status**: `template_created`

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
* **Test Name**: `HeadOfBusDevWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HeadOfBusDevWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **visit** (Selector: `None`, Value: `/management/head-of-bus-dev-workflow`)
3. **should_be_visible** (Selector: `head_of_bus_dev_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `head_of_bus_dev_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `head_of_bus_dev_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
