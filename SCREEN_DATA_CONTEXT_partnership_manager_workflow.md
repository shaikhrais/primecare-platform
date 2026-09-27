# SCREEN DATA CONTEXT: partnership_manager_workflow

Below are the database records from `governance.db` used to configure and build the **Partnership Manager - PartnershipManagerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `215`
* **App ID**: `1`
* **Role ID**: `41`
* **Screen Code**: `partnership_manager_workflow`
* **Screen Name**: `PartnershipManagerWorkflowScreen`
* **Route Path**: `/management/partnership-manager-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/partnership_manager_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `41`
* **Role Code**: `partnership`
* **Role Name**: `Partnership Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Partnership Manager personnel to oversee, audit, and coordinate operations related to partnershipmanagerworkflowscreen.`
* **User Story**: `As a Partnership Manager, I want to access the PartnershipManagerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PartnershipManagerWorkflowScreen`
* **Acceptance Criteria**:
- The PartnershipManagerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Partnership Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `partnership_manager_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `partnership_manager_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `partnership_manager_workflow-content` (Type: layout, Required: 1)
* **partnershipmanagerworkflow_btn_1** -> `partnershipmanagerworkflow-btn-1` (Type: button, Required: 0)
* **partnershipmanagerworkflow_title** -> `partnershipmanagerworkflow-title` (Type: header, Required: 0)
* **partnershipmanagerworkflow_content** -> `partnershipmanagerworkflow-content` (Type: layout, Required: 0)
* **partnershipmanagerworkflow_screen** -> `partnershipmanagerworkflow-screen` (Type: layout, Required: 0)
* **partnershipmanagerworkflow_btn_2** -> `partnershipmanagerworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `223` (Required: 1)
* Component ID: `757` (Required: 1)
* Component ID: `1291` (Required: 1)
* Component ID: `3496` (Required: 1)
* Component ID: `3497` (Required: 1)
* Component ID: `3498` (Required: 1)
* Component ID: `3499` (Required: 1)
* Component ID: `3500` (Required: 1)
* Component ID: `3501` (Required: 1)
* Component ID: `3502` (Required: 1)
* Component ID: `3503` (Required: 1)
* Component ID: `3504` (Required: 1)
* Component ID: `3505` (Required: 1)
* Component ID: `3506` (Required: 1)

## 7. API / Data Mapping
* API ID: `4504` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `partnership_manager_workflow_runtime`
* **Test Name**: `PartnershipManagerWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PartnershipManagerWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `partnership`)
2. **visit** (Selector: `None`, Value: `/management/partnership-manager-workflow`)
3. **should_be_visible** (Selector: `partnership_manager_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `partnership_manager_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `partnership_manager_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
