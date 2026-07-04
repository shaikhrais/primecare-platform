# SCREEN DATA CONTEXT: guest_workflow

Below are the database records from `governance.db` used to configure and build the **Guest - GuestWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `115`
* **App ID**: `1`
* **Role ID**: `13`
* **Screen Code**: `guest_workflow`
* **Screen Name**: `GuestWorkflowScreen`
* **Route Path**: `/common/guest-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/guest_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Guest personnel to oversee, audit, and coordinate operations related to guestworkflowscreen.`
* **User Story**: `As a Guest, I want to access the GuestWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GuestWorkflowScreen`
* **Acceptance Criteria**:
- The GuestWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `guest_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `guest_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `guest_workflow-content` (Type: layout, Required: 1)
* **guestworkflow_content** -> `guestworkflow-content` (Type: layout, Required: 0)
* **guestworkflow_btn_3** -> `guestworkflow-btn-3` (Type: button, Required: 0)
* **guestworkflow_btn_2** -> `guestworkflow-btn-2` (Type: button, Required: 0)
* **guestworkflow_screen** -> `guestworkflow-screen` (Type: layout, Required: 0)
* **guestworkflow_loading** -> `guestworkflow-loading` (Type: loading, Required: 0)
* **guestworkflow_title** -> `guestworkflow-title` (Type: header, Required: 0)
* **guestworkflow_btn_1** -> `guestworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `123` (Required: 1)
* Component ID: `657` (Required: 1)
* Component ID: `1191` (Required: 1)
* Component ID: `2584` (Required: 1)
* Component ID: `2585` (Required: 1)
* Component ID: `2586` (Required: 1)
* Component ID: `2587` (Required: 1)

## 7. API / Data Mapping
* API ID: `4392` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `guest_workflow_runtime`
* **Test Name**: `GuestWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `GuestWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/common/guest-workflow`)
3. **should_be_visible** (Selector: `guest_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `guest_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `guest_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
