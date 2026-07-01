# SCREEN DATA CONTEXT: hr_hiring_workflow

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - HrHiringWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `256`
* **App ID**: `1`
* **Role ID**: `45`
* **Screen Code**: `hr_hiring_workflow`
* **Screen Name**: `HrHiringWorkflowScreen`
* **Route Path**: `/staff/hr-hiring-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/hr_hiring_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `45`
* **Role Code**: `hr_hiring`
* **Role Name**: `Talent Acquisition Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to hrhiringworkflowscreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the HrHiringWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrHiringWorkflowScreen`
* **Acceptance Criteria**:
- The HrHiringWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_hiring_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_hiring_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `hr_hiring_workflow-content` (Type: layout, Required: 1)
* **hrhiringworkflow_btn_3** -> `hrhiringworkflow-btn-3` (Type: button, Required: 0)
* **hrhiringworkflow_content** -> `hrhiringworkflow-content` (Type: layout, Required: 0)
* **hrhiringworkflow_screen** -> `hrhiringworkflow-screen` (Type: layout, Required: 0)
* **hrhiringworkflow_btn_2** -> `hrhiringworkflow-btn-2` (Type: button, Required: 0)
* **hrhiringworkflow_title** -> `hrhiringworkflow-title` (Type: header, Required: 0)
* **hrhiringworkflow_btn_1** -> `hrhiringworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `264` (Required: 1)
* Component ID: `798` (Required: 1)
* Component ID: `1332` (Required: 1)
* Component ID: `3880` (Required: 1)
* Component ID: `3881` (Required: 1)
* Component ID: `3882` (Required: 1)
* Component ID: `3883` (Required: 1)
* Component ID: `3884` (Required: 1)
* Component ID: `3885` (Required: 1)
* Component ID: `3886` (Required: 1)
* Component ID: `3887` (Required: 1)
* Component ID: `3888` (Required: 1)
* Component ID: `3889` (Required: 1)

## 7. API / Data Mapping
* API ID: `4571` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_hiring_workflow_runtime`
* **Test Name**: `HrHiringWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HR Hiring Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HR Hiring Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `HR Hiring Workflow`)
5. **check_url** (Selector: `None`, Value: `/staff/hr-hiring-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
