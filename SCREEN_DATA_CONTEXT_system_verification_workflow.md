# SCREEN DATA CONTEXT: system_verification_workflow

Below are the database records from `governance.db` used to configure and build the **System Verification Officer - SystemVerificationWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `148`
* **App ID**: `1`
* **Role ID**: `18`
* **Screen Code**: `system_verification_workflow`
* **Screen Name**: `SystemVerificationWorkflowScreen`
* **Route Path**: `/common/system-verification-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/system_verification_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `18`
* **Role Code**: `system_verification`
* **Role Name**: `System Verification Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable System Verification Officer personnel to oversee, audit, and coordinate operations related to systemverificationworkflowscreen.`
* **User Story**: `As a System Verification Officer, I want to access the SystemVerificationWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SystemVerificationWorkflowScreen`
* **Acceptance Criteria**:
- The SystemVerificationWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only System Verification Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `system_verification_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `system_verification_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `system_verification_workflow-content` (Type: layout, Required: 1)
* **systemverificationworkflow_content** -> `systemverificationworkflow-content` (Type: layout, Required: 0)
* **systemverificationworkflow_screen** -> `systemverificationworkflow-screen` (Type: layout, Required: 0)
* **systemverificationworkflow_btn_1** -> `systemverificationworkflow-btn-1` (Type: button, Required: 0)
* **systemverificationworkflow_btn_2** -> `systemverificationworkflow-btn-2` (Type: button, Required: 0)
* **systemverificationworkflow_title** -> `systemverificationworkflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `156` (Required: 1)
* Component ID: `690` (Required: 1)
* Component ID: `1224` (Required: 1)
* Component ID: `2870` (Required: 1)
* Component ID: `2871` (Required: 1)
* Component ID: `2872` (Required: 1)
* Component ID: `2873` (Required: 1)
* Component ID: `2874` (Required: 1)
* Component ID: `2875` (Required: 1)
* Component ID: `2876` (Required: 1)
* Component ID: `2877` (Required: 1)
* Component ID: `2878` (Required: 1)
* Component ID: `2879` (Required: 1)

## 7. API / Data Mapping
* API ID: `4431` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `system_verification_workflow_runtime`
* **Test Name**: `SystemVerificationWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `System Verification Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `system_verification`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `System Verification Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `System Verification Workflow`)
5. **check_url** (Selector: `None`, Value: `/common/system-verification-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
