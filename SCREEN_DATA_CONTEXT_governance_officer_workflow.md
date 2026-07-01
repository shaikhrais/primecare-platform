# SCREEN DATA CONTEXT: governance_officer_workflow

Below are the database records from `governance.db` used to configure and build the **Governance Officer - GovernanceOfficerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `200`
* **App ID**: `1`
* **Role ID**: `36`
* **Screen Code**: `governance_officer_workflow`
* **Screen Name**: `GovernanceOfficerWorkflowScreen`
* **Route Path**: `/management/governance-officer-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/governance_officer_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to governanceofficerworkflowscreen.`
* **User Story**: `As a Governance Officer, I want to access the GovernanceOfficerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GovernanceOfficerWorkflowScreen`
* **Acceptance Criteria**:
- The GovernanceOfficerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `governance_officer_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `governance_officer_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `governance_officer_workflow-content` (Type: layout, Required: 1)
* **governanceofficerworkflow_btn_1** -> `governanceofficerworkflow-btn-1` (Type: button, Required: 0)
* **governanceofficerworkflow_title** -> `governanceofficerworkflow-title` (Type: header, Required: 0)
* **governanceofficerworkflow_screen** -> `governanceofficerworkflow-screen` (Type: layout, Required: 0)
* **governanceofficerworkflow_btn_2** -> `governanceofficerworkflow-btn-2` (Type: button, Required: 0)
* **governanceofficerworkflow_content** -> `governanceofficerworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `208` (Required: 1)
* Component ID: `742` (Required: 1)
* Component ID: `1276` (Required: 1)
* Component ID: `3353` (Required: 1)
* Component ID: `3354` (Required: 1)
* Component ID: `3355` (Required: 1)
* Component ID: `3356` (Required: 1)
* Component ID: `3357` (Required: 1)
* Component ID: `3358` (Required: 1)
* Component ID: `3359` (Required: 1)
* Component ID: `3360` (Required: 1)
* Component ID: `3361` (Required: 1)
* Component ID: `3362` (Required: 1)

## 7. API / Data Mapping
* API ID: `4489` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `governance_officer_workflow_runtime`
* **Test Name**: `GovernanceOfficerWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Governance Officer Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Governance Officer Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Governance Officer Workflow`)
5. **check_url** (Selector: `None`, Value: `/management/governance-officer-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
