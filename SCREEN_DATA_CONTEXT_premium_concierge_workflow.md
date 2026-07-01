# SCREEN DATA CONTEXT: premium_concierge_workflow

Below are the database records from `governance.db` used to configure and build the **Premium Concierge Care Coordinator - PremiumConciergeCareCoordinatorComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `608`
* **App ID**: `1`
* **Role ID**: `49`
* **Screen Code**: `premium_concierge_workflow`
* **Screen Name**: `PremiumConciergeCareCoordinatorComplianceWorkflowScreen`
* **Route Path**: `/premium/premium-concierge-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/premium/premium_concierge_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `49`
* **Role Code**: `premium_concierge`
* **Role Name**: `Premium Concierge Care Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Premium Concierge Care Coordinator personnel to oversee, audit, and coordinate operations related to premium concierge care coordinator compliance workflow.`
* **User Story**: `As a Premium Concierge Care Coordinator, I want to access the Premium Concierge Care Coordinator Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Premium Concierge Care Coordinator Compliance Workflow`
* **Acceptance Criteria**:
- The Premium Concierge Care Coordinator Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Premium Concierge Care Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `premium_concierge_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `premium_concierge_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `premium_concierge_workflow-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `532` (Required: 1)
* Component ID: `1066` (Required: 1)
* Component ID: `1600` (Required: 1)
* Component ID: `6311` (Required: 1)
* Component ID: `6312` (Required: 1)
* Component ID: `6313` (Required: 1)
* Component ID: `6314` (Required: 1)
* Component ID: `6315` (Required: 1)
* Component ID: `6316` (Required: 1)

## 7. API / Data Mapping
* API ID: `4957` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `premium_concierge_workflow_runtime`
* **Test Name**: `Premium Concierge Care Coordinator Compliance Workflow Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Premium Concierge Care Coordinator Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `premium_concierge`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Premium Concierge Care Coordinator Compliance Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Premium Concierge Care Coordinator Compliance Workflow`)
5. **check_url** (Selector: `None`, Value: `/premium/premium-concierge-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
