# SCREEN DATA CONTEXT: office_workflow

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - OfficeWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `124`
* **App ID**: `1`
* **Role ID**: `59`
* **Screen Code**: `office_workflow`
* **Screen Name**: `OfficeWorkflowScreen`
* **Route Path**: `/common/office-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/office_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to officeworkflowscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the OfficeWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OfficeWorkflowScreen`
* **Acceptance Criteria**:
- The OfficeWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `office_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `office_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `office_workflow-content` (Type: layout, Required: 1)
* **officeworkflow_content** -> `officeworkflow-content` (Type: layout, Required: 0)
* **officeworkflow_title** -> `officeworkflow-title` (Type: header, Required: 0)
* **officeworkflow_screen** -> `officeworkflow-screen` (Type: layout, Required: 0)
* **officeworkflow_btn_1** -> `officeworkflow-btn-1` (Type: button, Required: 0)
* **officeworkflow_btn_2** -> `officeworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `132` (Required: 1)
* Component ID: `666` (Required: 1)
* Component ID: `1200` (Required: 1)
* Component ID: `2663` (Required: 1)
* Component ID: `2664` (Required: 1)
* Component ID: `2665` (Required: 1)
* Component ID: `2666` (Required: 1)
* Component ID: `2667` (Required: 1)
* Component ID: `2668` (Required: 1)
* Component ID: `2669` (Required: 1)
* Component ID: `2670` (Required: 1)
* Component ID: `2671` (Required: 1)
* Component ID: `2672` (Required: 1)

## 7. API / Data Mapping
* API ID: `4407` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `office_workflow_runtime`
* **Test Name**: `OfficeWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OfficeWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/common/office-workflow`)
3. **should_be_visible** (Selector: `office_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `office_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `office_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
