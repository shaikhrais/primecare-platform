# SCREEN DATA CONTEXT: family_member_workflow

Below are the database records from `governance.db` used to configure and build the **Family Member - FamilyMemberWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `109`
* **App ID**: `1`
* **Role ID**: `64`
* **Screen Code**: `family_member_workflow`
* **Screen Name**: `FamilyMemberWorkflowScreen`
* **Route Path**: `/common/family-member-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/family_member_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `64`
* **Role Code**: `family`
* **Role Name**: `Family Member`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Family Member personnel to oversee, audit, and coordinate operations related to familymemberworkflowscreen.`
* **User Story**: `As a Family Member, I want to access the FamilyMemberWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FamilyMemberWorkflowScreen`
* **Acceptance Criteria**:
- The FamilyMemberWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Family Member access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `family_member_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `family_member_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `family_member_workflow-content` (Type: layout, Required: 1)
* **familymemberworkflow_btn_2** -> `familymemberworkflow-btn-2` (Type: button, Required: 0)
* **familymemberworkflow_title** -> `familymemberworkflow-title` (Type: header, Required: 0)
* **familymemberworkflow_screen** -> `familymemberworkflow-screen` (Type: layout, Required: 0)
* **familymemberworkflow_btn_1** -> `familymemberworkflow-btn-1` (Type: button, Required: 0)
* **familymemberworkflow_content** -> `familymemberworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `117` (Required: 1)
* Component ID: `651` (Required: 1)
* Component ID: `1185` (Required: 1)
* Component ID: `2541` (Required: 1)
* Component ID: `2542` (Required: 1)
* Component ID: `2543` (Required: 1)
* Component ID: `2544` (Required: 1)

## 7. API / Data Mapping
* API ID: `4386` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `family_member_workflow_runtime`
* **Test Name**: `FamilyMemberWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FamilyMemberWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `family`)
2. **visit** (Selector: `None`, Value: `/common/family-member-workflow`)
3. **should_be_visible** (Selector: `family_member_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `family_member_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `family_member_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
