# SCREEN DATA CONTEXT: franchise_sales_workflow

Below are the database records from `governance.db` used to configure and build the **Franchise Sales Manager - FranchiseSalesManagerComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `606`
* **App ID**: `1`
* **Role ID**: `34`
* **Screen Code**: `franchise_sales_workflow`
* **Screen Name**: `FranchiseSalesManagerComplianceWorkflowScreen`
* **Route Path**: `/executive/franchise-sales-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_sales_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `34`
* **Role Code**: `franchise_sales`
* **Role Name**: `Franchise Sales Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Sales Manager personnel to oversee, audit, and coordinate operations related to franchise sales manager compliance workflow.`
* **User Story**: `As a Franchise Sales Manager, I want to access the Franchise Sales Manager Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Franchise Sales Manager Compliance Workflow`
* **Acceptance Criteria**:
- The Franchise Sales Manager Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Sales Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_sales_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_sales_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_sales_workflow-content` (Type: layout, Required: 1)
* **franchise sales manager compliance workflow_content** -> `franchise sales manager compliance workflow-content` (Type: layout, Required: 0)
* **franchise sales manager compliance workflow_btn_1** -> `franchise sales manager compliance workflow-btn-1` (Type: button, Required: 0)
* **franchise sales manager compliance workflow_screen** -> `franchise sales manager compliance workflow-screen` (Type: layout, Required: 0)
* **franchise sales manager compliance workflow_title** -> `franchise sales manager compliance workflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `530` (Required: 1)
* Component ID: `1064` (Required: 1)
* Component ID: `1598` (Required: 1)
* Component ID: `6299` (Required: 1)
* Component ID: `6300` (Required: 1)
* Component ID: `6301` (Required: 1)
* Component ID: `6302` (Required: 1)
* Component ID: `6303` (Required: 1)
* Component ID: `6304` (Required: 1)
* Component ID: `6305` (Required: 1)
* Component ID: `6306` (Required: 1)

## 7. API / Data Mapping
* API ID: `4955` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_sales_workflow_runtime`
* **Test Name**: `Franchise Sales Manager Compliance Workflow Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Sales Manager Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `franchise_sales`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Sales Manager Compliance Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Sales Manager Compliance Workflow`)
5. **check_url** (Selector: `None`, Value: `/executive/franchise-sales-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
