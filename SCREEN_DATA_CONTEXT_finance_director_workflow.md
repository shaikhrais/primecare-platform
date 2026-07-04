# SCREEN DATA CONTEXT: finance_director_workflow

Below are the database records from `governance.db` used to configure and build the **Finance Director - FinanceDirectorWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `170`
* **App ID**: `1`
* **Role ID**: `26`
* **Screen Code**: `finance_director_workflow`
* **Screen Name**: `FinanceDirectorWorkflowScreen`
* **Route Path**: `/executive/finance-director-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/finance_director_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `26`
* **Role Code**: `finance_director`
* **Role Name**: `Finance Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Finance Director personnel to oversee, audit, and coordinate operations related to financedirectorworkflowscreen.`
* **User Story**: `As a Finance Director, I want to access the FinanceDirectorWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FinanceDirectorWorkflowScreen`
* **Acceptance Criteria**:
- The FinanceDirectorWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Finance Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `finance_director_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `finance_director_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `finance_director_workflow-content` (Type: layout, Required: 1)
* **financedirectorworkflow_content** -> `financedirectorworkflow-content` (Type: layout, Required: 0)
* **financedirectorworkflow_screen** -> `financedirectorworkflow-screen` (Type: layout, Required: 0)
* **financedirectorworkflow_title** -> `financedirectorworkflow-title` (Type: header, Required: 0)
* **financedirectorworkflow_btn_2** -> `financedirectorworkflow-btn-2` (Type: button, Required: 0)
* **financedirectorworkflow_btn_1** -> `financedirectorworkflow-btn-1` (Type: button, Required: 0)
* **financedirectorworkflow_btn_3** -> `financedirectorworkflow-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `178` (Required: 1)
* Component ID: `712` (Required: 1)
* Component ID: `1246` (Required: 1)
* Component ID: `3080` (Required: 1)
* Component ID: `3081` (Required: 1)
* Component ID: `3082` (Required: 1)
* Component ID: `3083` (Required: 1)
* Component ID: `3084` (Required: 1)
* Component ID: `3085` (Required: 1)
* Component ID: `3086` (Required: 1)
* Component ID: `3087` (Required: 1)
* Component ID: `3088` (Required: 1)
* Component ID: `3089` (Required: 1)

## 7. API / Data Mapping
* API ID: `4459` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `finance_director_workflow_runtime`
* **Test Name**: `FinanceDirectorWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FinanceDirectorWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `finance_director`)
2. **visit** (Selector: `None`, Value: `/executive/finance-director-workflow`)
3. **should_be_visible** (Selector: `finance_director_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `finance_director_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `finance_director_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
