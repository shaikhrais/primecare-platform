# SCREEN DATA CONTEXT: support_workflow

Below are the database records from `governance.db` used to configure and build the **Customer Support - SupportWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `143`
* **App ID**: `1`
* **Role ID**: `61`
* **Screen Code**: `support_workflow`
* **Screen Name**: `SupportWorkflowScreen`
* **Route Path**: `/common/support-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/support_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `61`
* **Role Code**: `customer_support`
* **Role Name**: `Customer Support`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Customer Support personnel to oversee, audit, and coordinate operations related to supportworkflowscreen.`
* **User Story**: `As a Customer Support, I want to access the SupportWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SupportWorkflowScreen`
* **Acceptance Criteria**:
- The SupportWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Customer Support access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `support_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `support_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `support_workflow-content` (Type: layout, Required: 1)
* **supportworkflow_screen** -> `supportworkflow-screen` (Type: layout, Required: 0)
* **supportworkflow_btn_1** -> `supportworkflow-btn-1` (Type: button, Required: 0)
* **supportworkflow_content** -> `supportworkflow-content` (Type: layout, Required: 0)
* **supportworkflow_btn_2** -> `supportworkflow-btn-2` (Type: button, Required: 0)
* **supportworkflow_title** -> `supportworkflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `151` (Required: 1)
* Component ID: `685` (Required: 1)
* Component ID: `1219` (Required: 1)
* Component ID: `2824` (Required: 1)
* Component ID: `2825` (Required: 1)
* Component ID: `2826` (Required: 1)
* Component ID: `2827` (Required: 1)
* Component ID: `2828` (Required: 1)
* Component ID: `2829` (Required: 1)
* Component ID: `2830` (Required: 1)
* Component ID: `2831` (Required: 1)
* Component ID: `2832` (Required: 1)
* Component ID: `2833` (Required: 1)

## 7. API / Data Mapping
* API ID: `4426` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `support_workflow_runtime`
* **Test Name**: `SupportWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Support Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Support Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Support Workflow`)
5. **check_url** (Selector: `None`, Value: `/common/support-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
