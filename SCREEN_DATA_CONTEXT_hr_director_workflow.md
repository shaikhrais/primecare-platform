# SCREEN DATA CONTEXT: hr_director_workflow

Below are the database records from `governance.db` used to configure and build the **HR Director - HrDirectorWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `173`
* **App ID**: `1`
* **Role ID**: `27`
* **Screen Code**: `hr_director_workflow`
* **Screen Name**: `HrDirectorWorkflowScreen`
* **Route Path**: `/executive/hr-director-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/hr_director_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrdirectorworkflowscreen.`
* **User Story**: `As a HR Director, I want to access the HrDirectorWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrDirectorWorkflowScreen`
* **Acceptance Criteria**:
- The HrDirectorWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_director_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_director_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `hr_director_workflow-content` (Type: layout, Required: 1)
* **hrdirectorworkflow_content** -> `hrdirectorworkflow-content` (Type: layout, Required: 0)
* **hrdirectorworkflow_screen** -> `hrdirectorworkflow-screen` (Type: layout, Required: 0)
* **hrdirectorworkflow_btn_1** -> `hrdirectorworkflow-btn-1` (Type: button, Required: 0)
* **hrdirectorworkflow_title** -> `hrdirectorworkflow-title` (Type: header, Required: 0)
* **hrdirectorworkflow_btn_2** -> `hrdirectorworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `181` (Required: 1)
* Component ID: `715` (Required: 1)
* Component ID: `1249` (Required: 1)
* Component ID: `3110` (Required: 1)
* Component ID: `3111` (Required: 1)
* Component ID: `3112` (Required: 1)
* Component ID: `3113` (Required: 1)
* Component ID: `3114` (Required: 1)
* Component ID: `3115` (Required: 1)
* Component ID: `3116` (Required: 1)
* Component ID: `3117` (Required: 1)
* Component ID: `3118` (Required: 1)

## 7. API / Data Mapping
* API ID: `4462` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_director_workflow_runtime`
* **Test Name**: `HrDirectorWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrDirectorWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **visit** (Selector: `None`, Value: `/executive/hr-director-workflow`)
3. **should_be_visible** (Selector: `hr_director_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_director_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_director_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
