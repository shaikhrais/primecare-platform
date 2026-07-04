# SCREEN DATA CONTEXT: billing_admin_workflow

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - BillingAdminWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `249`
* **App ID**: `1`
* **Role ID**: `59`
* **Screen Code**: `billing_admin_workflow`
* **Screen Name**: `BillingAdminWorkflowScreen`
* **Route Path**: `/staff/billing-admin-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/billing_admin_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to billingadminworkflowscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the BillingAdminWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BillingAdminWorkflowScreen`
* **Acceptance Criteria**:
- The BillingAdminWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `billing_admin_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `billing_admin_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `billing_admin_workflow-content` (Type: layout, Required: 1)
* **billingadminworkflow_btn_2** -> `billingadminworkflow-btn-2` (Type: button, Required: 0)
* **billingadminworkflow_content** -> `billingadminworkflow-content` (Type: layout, Required: 0)
* **billingadminworkflow_title** -> `billingadminworkflow-title` (Type: header, Required: 0)
* **billingadminworkflow_screen** -> `billingadminworkflow-screen` (Type: layout, Required: 0)
* **billingadminworkflow_btn_3** -> `billingadminworkflow-btn-3` (Type: button, Required: 0)
* **billingadminworkflow_btn_1** -> `billingadminworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `257` (Required: 1)
* Component ID: `791` (Required: 1)
* Component ID: `1325` (Required: 1)
* Component ID: `3810` (Required: 1)
* Component ID: `3811` (Required: 1)
* Component ID: `3812` (Required: 1)
* Component ID: `3813` (Required: 1)
* Component ID: `3814` (Required: 1)
* Component ID: `3815` (Required: 1)
* Component ID: `3816` (Required: 1)
* Component ID: `3817` (Required: 1)
* Component ID: `3818` (Required: 1)
* Component ID: `3819` (Required: 1)

## 7. API / Data Mapping
* API ID: `4562` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `billing_admin_workflow_runtime`
* **Test Name**: `BillingAdminWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `BillingAdminWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/staff/billing-admin-workflow`)
3. **should_be_visible** (Selector: `billing_admin_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `billing_admin_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `billing_admin_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
