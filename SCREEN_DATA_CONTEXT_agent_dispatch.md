# SCREEN DATA CONTEXT: agent_dispatch

Below are the database records from `governance.db` used to configure and build the **Governance Officer - AgentDispatchScreen** screen.

---

## 1. Screen Record
* **ID**: `583`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `agent_dispatch`
* **Screen Name**: `AgentDispatchScreen`
* **Route Path**: `/common/agent-dispatch`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/agent_dispatch_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to agentdispatchscreen.`
* **User Story**: `As a Governance Officer, I want to access the AgentDispatchScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `AgentDispatchScreen`
* **Acceptance Criteria**:
- The AgentDispatchScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `agent_dispatch-screen` (Type: layout, Required: 1)
* **page_title** -> `agent_dispatch-title` (Type: header, Required: 1)
* **primary_content** -> `agent_dispatch-content` (Type: layout, Required: 1)
* **agentdispatch_screen** -> `agentdispatch-screen` (Type: layout, Required: 0)
* **agentdispatch_title** -> `agentdispatch-title` (Type: header, Required: 0)
* **agentdispatch_content** -> `agentdispatch-content` (Type: layout, Required: 0)
* **agentdispatch_btn_3** -> `agentdispatch-btn-3` (Type: button, Required: 0)
* **agentdispatch_loading** -> `agentdispatch-loading` (Type: loading, Required: 0)
* **agentdispatch_btn_2** -> `agentdispatch-btn-2` (Type: button, Required: 0)
* **agentdispatch_btn_1** -> `agentdispatch-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `507` (Required: 1)
* Component ID: `1041` (Required: 1)
* Component ID: `1575` (Required: 1)
* Component ID: `6082` (Required: 1)
* Component ID: `6083` (Required: 1)
* Component ID: `6084` (Required: 1)
* Component ID: `6085` (Required: 1)
* Component ID: `6086` (Required: 1)
* Component ID: `6087` (Required: 1)
* Component ID: `6088` (Required: 1)
* Component ID: `6089` (Required: 1)
* Component ID: `6090` (Required: 1)
* Component ID: `6091` (Required: 1)

## 7. API / Data Mapping
* API ID: `4930` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `agent_dispatch_runtime`
* **Test Name**: `AgentDispatchScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Agent Dispatch`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Agent Dispatch`)
4. **click_sidebar_link** (Selector: `None`, Value: `Agent Dispatch`)
5. **check_url** (Selector: `None`, Value: `/common/agent-dispatch`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
