# SCREEN DATA CONTEXT: business_development_workflow

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - BusinessDevelopmentWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `91`
* **App ID**: `1`
* **Role ID**: `37`
* **Screen Code**: `business_development_workflow`
* **Screen Name**: `BusinessDevelopmentWorkflowScreen`
* **Route Path**: `/common/business-development-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/business_development_workflow_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to businessdevelopmentworkflowscreen.`
* **User Story**: `As a Head of Business Development, I want to access the BusinessDevelopmentWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BusinessDevelopmentWorkflowScreen`
* **Acceptance Criteria**:
- The BusinessDevelopmentWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `business_development_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `business_development_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `business_development_workflow-content` (Type: layout, Required: 1)
* **businessdevelopmentworkflow_screen** -> `businessdevelopmentworkflow-screen` (Type: layout, Required: 0)
* **businessdevelopmentworkflow_title** -> `businessdevelopmentworkflow-title` (Type: header, Required: 0)
* **businessdevelopmentworkflow_content** -> `businessdevelopmentworkflow-content` (Type: layout, Required: 0)
* **businessdevelopmentworkflow_btn_2** -> `businessdevelopmentworkflow-btn-2` (Type: button, Required: 0)
* **businessdevelopmentworkflow_btn_1** -> `businessdevelopmentworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `99` (Required: 1)
* Component ID: `633` (Required: 1)
* Component ID: `1167` (Required: 1)
* Component ID: `2391` (Required: 1)
* Component ID: `2392` (Required: 1)
* Component ID: `2393` (Required: 1)
* Component ID: `2394` (Required: 1)
* Component ID: `2395` (Required: 1)
* Component ID: `2396` (Required: 1)
* Component ID: `2397` (Required: 1)
* Component ID: `2398` (Required: 1)
* Component ID: `2399` (Required: 1)
* Component ID: `2400` (Required: 1)

## 7. API / Data Mapping
* API ID: `4368` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `business_development_workflow_runtime`
* **Test Name**: `BusinessDevelopmentWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Business Development Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Business Development Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Business Development Workflow`)
5. **check_url** (Selector: `None`, Value: `/common/business-development-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
