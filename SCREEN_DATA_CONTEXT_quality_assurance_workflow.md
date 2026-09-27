# SCREEN DATA CONTEXT: quality_assurance_workflow

Below are the database records from `governance.db` used to configure and build the **QA Specialist - QualityAssuranceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `265`
* **App ID**: `1`
* **Role ID**: `63`
* **Screen Code**: `quality_assurance_workflow`
* **Screen Name**: `QualityAssuranceWorkflowScreen`
* **Route Path**: `/staff/quality-assurance-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/quality_assurance_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `63`
* **Role Code**: `qa_specialist`
* **Role Name**: `QA Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable QA Specialist personnel to oversee, audit, and coordinate operations related to qualityassuranceworkflowscreen.`
* **User Story**: `As a QA Specialist, I want to access the QualityAssuranceWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `QualityAssuranceWorkflowScreen`
* **Acceptance Criteria**:
- The QualityAssuranceWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only QA Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `quality_assurance_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `quality_assurance_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `quality_assurance_workflow-content` (Type: layout, Required: 1)
* **qualityassuranceworkflow_screen** -> `qualityassuranceworkflow-screen` (Type: layout, Required: 0)
* **qualityassuranceworkflow_btn_1** -> `qualityassuranceworkflow-btn-1` (Type: button, Required: 0)
* **qualityassuranceworkflow_btn_3** -> `qualityassuranceworkflow-btn-3` (Type: button, Required: 0)
* **qualityassuranceworkflow_content** -> `qualityassuranceworkflow-content` (Type: layout, Required: 0)
* **qualityassuranceworkflow_title** -> `qualityassuranceworkflow-title` (Type: header, Required: 0)
* **qualityassuranceworkflow_btn_2** -> `qualityassuranceworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `273` (Required: 1)
* Component ID: `807` (Required: 1)
* Component ID: `1341` (Required: 1)
* Component ID: `3960` (Required: 1)
* Component ID: `3961` (Required: 1)
* Component ID: `3962` (Required: 1)
* Component ID: `3963` (Required: 1)
* Component ID: `3964` (Required: 1)
* Component ID: `3965` (Required: 1)
* Component ID: `3966` (Required: 1)
* Component ID: `3967` (Required: 1)
* Component ID: `3968` (Required: 1)
* Component ID: `3969` (Required: 1)

## 7. API / Data Mapping
* API ID: `4586` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `quality_assurance_workflow_runtime`
* **Test Name**: `QualityAssuranceWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `QualityAssuranceWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **visit** (Selector: `None`, Value: `/staff/quality-assurance-workflow`)
3. **should_be_visible** (Selector: `quality_assurance_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `quality_assurance_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `quality_assurance_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
