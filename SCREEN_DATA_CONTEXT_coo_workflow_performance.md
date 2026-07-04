# SCREEN DATA CONTEXT: coo_workflow_performance

Below are the database records from `governance.db` used to configure and build the **Guest - CooWorkflowPerformanceScreen** screen.

---

## 1. Screen Record
* **ID**: `735`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `coo_workflow_performance`
* **Screen Name**: `CooWorkflowPerformanceScreen`
* **Route Path**: `/offices/corporate/roles/coo/workflow-performance`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/coo_workflow_performance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to coo workflow performance.`
* **User Story**: `As a Guest, I want to access the Coo Workflow Performance within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Coo Workflow Performance`
* **Acceptance Criteria**:
- The Coo Workflow Performance route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_workflow_performance-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_workflow_performance-title` (Type: header, Required: 1)
* **primary_content** -> `coo_workflow_performance-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7033` (Required: 1)
* Component ID: `7034` (Required: 1)
* Component ID: `7035` (Required: 1)
* Component ID: `7036` (Required: 1)
* Component ID: `7037` (Required: 1)

## 7. API / Data Mapping
* API ID: `5117` (Required: 1)
* API ID: `5118` (Required: 1)
* API ID: `5119` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_workflow_performance_runtime`
* **Test Name**: `Coo Workflow Performance Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Coo Workflow Performance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/coo/workflow-performance`)
3. **should_be_visible** (Selector: `coo_workflow_performance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_workflow_performance-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_workflow_performance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
