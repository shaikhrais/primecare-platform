# SCREEN DATA CONTEXT: customer_support_workflow

Below are the database records from `governance.db` used to configure and build the **Customer Support - CustomerSupportWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `103`
* **App ID**: `1`
* **Role ID**: `61`
* **Screen Code**: `customer_support_workflow`
* **Screen Name**: `CustomerSupportWorkflowScreen`
* **Route Path**: `/common/customer-support-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/customer_support_workflow_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Customer Support personnel to oversee, audit, and coordinate operations related to customersupportworkflowscreen.`
* **User Story**: `As a Customer Support, I want to access the CustomerSupportWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CustomerSupportWorkflowScreen`
* **Acceptance Criteria**:
- The CustomerSupportWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Customer Support access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `customer_support_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `customer_support_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `customer_support_workflow-content` (Type: layout, Required: 1)
* **customersupportworkflow_btn_1** -> `customersupportworkflow-btn-1` (Type: button, Required: 0)
* **customersupportworkflow_content** -> `customersupportworkflow-content` (Type: layout, Required: 0)
* **customersupportworkflow_title** -> `customersupportworkflow-title` (Type: header, Required: 0)
* **customersupportworkflow_screen** -> `customersupportworkflow-screen` (Type: layout, Required: 0)
* **customersupportworkflow_btn_2** -> `customersupportworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `111` (Required: 1)
* Component ID: `645` (Required: 1)
* Component ID: `1179` (Required: 1)
* Component ID: `2501` (Required: 1)
* Component ID: `2502` (Required: 1)
* Component ID: `2503` (Required: 1)
* Component ID: `2504` (Required: 1)
* Component ID: `2505` (Required: 1)
* Component ID: `2506` (Required: 1)
* Component ID: `2507` (Required: 1)
* Component ID: `2508` (Required: 1)
* Component ID: `2509` (Required: 1)
* Component ID: `2510` (Required: 1)

## 7. API / Data Mapping
* API ID: `4380` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `customer_support_workflow_runtime`
* **Test Name**: `CustomerSupportWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CustomerSupportWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **visit** (Selector: `None`, Value: `/common/customer-support-workflow`)
3. **should_be_visible** (Selector: `customer_support_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `customer_support_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `customer_support_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
