# SCREEN DATA CONTEXT: legal_workflow

Below are the database records from `governance.db` used to configure and build the **Legal Counsel - LegalWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `176`
* **App ID**: `1`
* **Role ID**: `28`
* **Screen Code**: `legal_workflow`
* **Screen Name**: `LegalWorkflowScreen`
* **Route Path**: `/executive/legal-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/legal_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `28`
* **Role Code**: `legal`
* **Role Name**: `Legal Counsel`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Legal Counsel personnel to oversee, audit, and coordinate operations related to legalworkflowscreen.`
* **User Story**: `As a Legal Counsel, I want to access the LegalWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `LegalWorkflowScreen`
* **Acceptance Criteria**:
- The LegalWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Legal Counsel access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `legal_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `legal_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `legal_workflow-content` (Type: layout, Required: 1)
* **legalworkflow_screen** -> `legalworkflow-screen` (Type: layout, Required: 0)
* **legalworkflow_btn_2** -> `legalworkflow-btn-2` (Type: button, Required: 0)
* **legalworkflow_loading** -> `legalworkflow-loading` (Type: loading, Required: 0)
* **legalworkflow_btn_1** -> `legalworkflow-btn-1` (Type: button, Required: 0)
* **legalworkflow_title** -> `legalworkflow-title` (Type: header, Required: 0)
* **legalworkflow_btn_3** -> `legalworkflow-btn-3` (Type: button, Required: 0)
* **legalworkflow_content** -> `legalworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `184` (Required: 1)
* Component ID: `718` (Required: 1)
* Component ID: `1252` (Required: 1)
* Component ID: `3139` (Required: 1)
* Component ID: `3140` (Required: 1)
* Component ID: `3141` (Required: 1)
* Component ID: `3142` (Required: 1)
* Component ID: `3143` (Required: 1)
* Component ID: `3144` (Required: 1)
* Component ID: `3145` (Required: 1)
* Component ID: `3146` (Required: 1)
* Component ID: `3147` (Required: 1)
* Component ID: `3148` (Required: 1)

## 7. API / Data Mapping
* API ID: `4465` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `legal_workflow_runtime`
* **Test Name**: `LegalWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Legal Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `legal`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Legal Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Legal Workflow`)
5. **check_url** (Selector: `None`, Value: `/executive/legal-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
