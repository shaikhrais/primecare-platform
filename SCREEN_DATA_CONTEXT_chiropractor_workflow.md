# SCREEN DATA CONTEXT: chiropractor_workflow

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `94`
* **App ID**: `1`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_workflow`
* **Screen Name**: `ChiropractorWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/chiropractor_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorworkflowscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorWorkflowScreen`
* **Acceptance Criteria**:
- The ChiropractorWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_workflow-content` (Type: layout, Required: 1)
* **chiropractorworkflow_content** -> `chiropractorworkflow-content` (Type: layout, Required: 0)
* **chiropractorworkflow_btn_1** -> `chiropractorworkflow-btn-1` (Type: button, Required: 0)
* **chiropractorworkflow_screen** -> `chiropractorworkflow-screen` (Type: layout, Required: 0)
* **chiropractorworkflow_title** -> `chiropractorworkflow-title` (Type: header, Required: 0)
* **chiropractorworkflow_btn_2** -> `chiropractorworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `102` (Required: 1)
* Component ID: `636` (Required: 1)
* Component ID: `1170` (Required: 1)
* Component ID: `2425` (Required: 1)
* Component ID: `2426` (Required: 1)
* Component ID: `2427` (Required: 1)
* Component ID: `2428` (Required: 1)
* Component ID: `2429` (Required: 1)
* Component ID: `2430` (Required: 1)
* Component ID: `2431` (Required: 1)

## 7. API / Data Mapping
* API ID: `4371` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_workflow_runtime`
* **Test Name**: `ChiropractorWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ChiropractorWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/workflow`)
3. **should_be_visible** (Selector: `chiropractor_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `chiropractor_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `chiropractor_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
