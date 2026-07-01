# SCREEN DATA CONTEXT: community_outreach_workflow

Below are the database records from `governance.db` used to configure and build the **Community Outreach Lead - CommunityOutreachWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `188`
* **App ID**: `1`
* **Role ID**: `32`
* **Screen Code**: `community_outreach_workflow`
* **Screen Name**: `CommunityOutreachWorkflowScreen`
* **Route Path**: `/management/community-outreach-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/community_outreach_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `32`
* **Role Code**: `community_outreach`
* **Role Name**: `Community Outreach Lead`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Community Outreach Lead personnel to oversee, audit, and coordinate operations related to communityoutreachworkflowscreen.`
* **User Story**: `As a Community Outreach Lead, I want to access the CommunityOutreachWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CommunityOutreachWorkflowScreen`
* **Acceptance Criteria**:
- The CommunityOutreachWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Community Outreach Lead access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `community_outreach_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `community_outreach_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `community_outreach_workflow-content` (Type: layout, Required: 1)
* **communityoutreachworkflow_btn_3** -> `communityoutreachworkflow-btn-3` (Type: button, Required: 0)
* **communityoutreachworkflow_btn_1** -> `communityoutreachworkflow-btn-1` (Type: button, Required: 0)
* **communityoutreachworkflow_title** -> `communityoutreachworkflow-title` (Type: header, Required: 0)
* **communityoutreachworkflow_loading** -> `communityoutreachworkflow-loading` (Type: loading, Required: 0)
* **communityoutreachworkflow_screen** -> `communityoutreachworkflow-screen` (Type: layout, Required: 0)
* **communityoutreachworkflow_btn_2** -> `communityoutreachworkflow-btn-2` (Type: button, Required: 0)
* **communityoutreachworkflow_content** -> `communityoutreachworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `196` (Required: 1)
* Component ID: `730` (Required: 1)
* Component ID: `1264` (Required: 1)
* Component ID: `3236` (Required: 1)
* Component ID: `3237` (Required: 1)
* Component ID: `3238` (Required: 1)
* Component ID: `3239` (Required: 1)
* Component ID: `3240` (Required: 1)
* Component ID: `3241` (Required: 1)
* Component ID: `3242` (Required: 1)
* Component ID: `3243` (Required: 1)
* Component ID: `3244` (Required: 1)
* Component ID: `3245` (Required: 1)

## 7. API / Data Mapping
* API ID: `4477` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `community_outreach_workflow_runtime`
* **Test Name**: `CommunityOutreachWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Community Outreach Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `community_outreach`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Community Outreach Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Community Outreach Workflow`)
5. **check_url** (Selector: `None`, Value: `/management/community-outreach-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
