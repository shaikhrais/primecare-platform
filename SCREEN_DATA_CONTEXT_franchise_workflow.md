# SCREEN DATA CONTEXT: franchise_workflow

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `112`
* **App ID**: `1`
* **Role ID**: `29`
* **Screen Code**: `franchise_workflow`
* **Screen Name**: `FranchiseWorkflowScreen`
* **Route Path**: `/common/franchise-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/franchise_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchiseworkflowscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseWorkflowScreen`
* **Acceptance Criteria**:
- The FranchiseWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_workflow-content` (Type: layout, Required: 1)
* **franchiseworkflow_screen** -> `franchiseworkflow-screen` (Type: layout, Required: 0)
* **franchiseworkflow_title** -> `franchiseworkflow-title` (Type: header, Required: 0)
* **franchiseworkflow_btn_1** -> `franchiseworkflow-btn-1` (Type: button, Required: 0)
* **franchiseworkflow_content** -> `franchiseworkflow-content` (Type: layout, Required: 0)
* **franchiseworkflow_btn_2** -> `franchiseworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `120` (Required: 1)
* Component ID: `654` (Required: 1)
* Component ID: `1188` (Required: 1)
* Component ID: `2563` (Required: 1)
* Component ID: `2564` (Required: 1)
* Component ID: `2565` (Required: 1)
* Component ID: `2566` (Required: 1)
* Component ID: `2567` (Required: 1)
* Component ID: `2568` (Required: 1)
* Component ID: `2569` (Required: 1)
* Component ID: `2570` (Required: 1)
* Component ID: `2571` (Required: 1)
* Component ID: `2572` (Required: 1)

## 7. API / Data Mapping
* API ID: `4389` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_workflow_runtime`
* **Test Name**: `FranchiseWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Workflow`)
5. **check_url** (Selector: `None`, Value: `/common/franchise-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
