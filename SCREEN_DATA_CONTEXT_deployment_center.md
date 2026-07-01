# SCREEN DATA CONTEXT: deployment_center

Below are the database records from `governance.db` used to configure and build the **Chief Technology Officer (CTO) - DeploymentCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `482`
* **App ID**: `7`
* **Role ID**: `24`
* **Screen Code**: `deployment_center`
* **Screen Name**: `DeploymentCenterScreen`
* **Route Path**: `/executive/deployment-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/deployment_center_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `24`
* **Role Code**: `cto`
* **Role Name**: `Chief Technology Officer (CTO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Technology Officer (CTO) personnel to oversee, audit, and coordinate operations related to deploymentcenterscreen.`
* **User Story**: `As a Chief Technology Officer (CTO), I want to access the DeploymentCenterScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `DeploymentCenterScreen`
* **Acceptance Criteria**:
- The DeploymentCenterScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Technology Officer (CTO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `deployment_center-screen` (Type: layout, Required: 1)
* **page_title** -> `deployment_center-title` (Type: header, Required: 1)
* **primary_content** -> `deployment_center-content` (Type: layout, Required: 1)
* **deploymentcenter_screen** -> `deploymentcenter-screen` (Type: layout, Required: 0)
* **deploymentcenter_content** -> `deploymentcenter-content` (Type: layout, Required: 0)
* **deploymentcenter_btn_1** -> `deploymentcenter-btn-1` (Type: button, Required: 0)
* **deploymentcenter_btn_2** -> `deploymentcenter-btn-2` (Type: button, Required: 0)
* **deploymentcenter_title** -> `deploymentcenter-title` (Type: header, Required: 0)
* **deploymentcenter_btn_3** -> `deploymentcenter-btn-3` (Type: button, Required: 0)
* **deploymentcenter_loading** -> `deploymentcenter-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `411` (Required: 1)
* Component ID: `945` (Required: 1)
* Component ID: `1479` (Required: 1)
* Component ID: `5204` (Required: 1)
* Component ID: `5205` (Required: 1)
* Component ID: `5206` (Required: 1)
* Component ID: `5207` (Required: 1)
* Component ID: `5208` (Required: 1)
* Component ID: `5209` (Required: 1)
* Component ID: `5210` (Required: 1)
* Component ID: `5211` (Required: 1)
* Component ID: `5212` (Required: 1)
* Component ID: `5213` (Required: 1)

## 7. API / Data Mapping
* API ID: `4799` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `deployment_center_runtime`
* **Test Name**: `DeploymentCenterScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Deployment Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cto`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Deployment Center`)
4. **click_sidebar_link** (Selector: `None`, Value: `Deployment Center`)
5. **check_url** (Selector: `None`, Value: `/executive/deployment-center`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
