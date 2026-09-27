# SCREEN DATA CONTEXT: vip_manager_workflow

Below are the database records from `governance.db` used to configure and build the **VIP Client Manager - VIPClientManagerComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `610`
* **App ID**: `1`
* **Role ID**: `50`
* **Screen Code**: `vip_manager_workflow`
* **Screen Name**: `VIPClientManagerComplianceWorkflowScreen`
* **Route Path**: `/executive/vip-manager-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/vip_manager_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `50`
* **Role Code**: `vip_manager`
* **Role Name**: `VIP Client Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable VIP Client Manager personnel to oversee, audit, and coordinate operations related to vip client manager compliance workflow.`
* **User Story**: `As a VIP Client Manager, I want to access the VIP Client Manager Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `VIP Client Manager Compliance Workflow`
* **Acceptance Criteria**:
- The VIP Client Manager Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only VIP Client Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `vip_manager_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `vip_manager_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `vip_manager_workflow-content` (Type: layout, Required: 1)
* **vip client manager compliance workflow_title** -> `vip client manager compliance workflow-title` (Type: header, Required: 0)
* **vip client manager compliance workflow_screen** -> `vip client manager compliance workflow-screen` (Type: layout, Required: 0)
* **vip client manager compliance workflow_content** -> `vip client manager compliance workflow-content` (Type: layout, Required: 0)
* **vip client manager compliance workflow_btn_1** -> `vip client manager compliance workflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `534` (Required: 1)
* Component ID: `1068` (Required: 1)
* Component ID: `1602` (Required: 1)
* Component ID: `6325` (Required: 1)
* Component ID: `6326` (Required: 1)
* Component ID: `6327` (Required: 1)
* Component ID: `6328` (Required: 1)
* Component ID: `6329` (Required: 1)
* Component ID: `6330` (Required: 1)
* Component ID: `6331` (Required: 1)
* Component ID: `6332` (Required: 1)

## 7. API / Data Mapping
* API ID: `4959` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `vip_manager_workflow_runtime`
* **Test Name**: `VIP Client Manager Compliance Workflow Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `VIP Client Manager Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `vip_manager`)
2. **visit** (Selector: `None`, Value: `/executive/vip-manager-workflow`)
3. **should_be_visible** (Selector: `vip_manager_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `vip_manager_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `vip_manager_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
