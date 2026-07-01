# SCREEN DATA CONTEXT: governance_control_room

Below are the database records from `governance.db` used to configure and build the **Governance Officer - GovernanceControlRoomScreen** screen.

---

## 1. Screen Record
* **ID**: `579`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `governance_control_room`
* **Screen Name**: `GovernanceControlRoomScreen`
* **Route Path**: `/common/governance-control-room`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/governance_control_room_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to governancecontrolroomscreen.`
* **User Story**: `As a Governance Officer, I want to access the GovernanceControlRoomScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GovernanceControlRoomScreen`
* **Acceptance Criteria**:
- The GovernanceControlRoomScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `governance_control_room-screen` (Type: layout, Required: 1)
* **page_title** -> `governance_control_room-title` (Type: header, Required: 1)
* **primary_content** -> `governance_control_room-content` (Type: layout, Required: 1)
* **governancecontrolroom_title** -> `governancecontrolroom-title` (Type: header, Required: 0)
* **governancecontrolroom_screen** -> `governancecontrolroom-screen` (Type: layout, Required: 0)
* **governancecontrolroom_btn_1** -> `governancecontrolroom-btn-1` (Type: button, Required: 0)
* **governancecontrolroom_btn_2** -> `governancecontrolroom-btn-2` (Type: button, Required: 0)
* **governancecontrolroom_content** -> `governancecontrolroom-content` (Type: layout, Required: 0)
* **governancecontrolroom_btn_3** -> `governancecontrolroom-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `503` (Required: 1)
* Component ID: `1037` (Required: 1)
* Component ID: `1571` (Required: 1)
* Component ID: `6043` (Required: 1)
* Component ID: `6044` (Required: 1)
* Component ID: `6045` (Required: 1)
* Component ID: `6046` (Required: 1)
* Component ID: `6047` (Required: 1)
* Component ID: `6048` (Required: 1)
* Component ID: `6049` (Required: 1)
* Component ID: `6050` (Required: 1)
* Component ID: `6051` (Required: 1)
* Component ID: `6052` (Required: 1)

## 7. API / Data Mapping
* API ID: `4926` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `governance_control_room_runtime`
* **Test Name**: `GovernanceControlRoomScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Governance Control Room`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Governance Control Room`)
4. **click_sidebar_link** (Selector: `None`, Value: `Governance Control Room`)
5. **check_url** (Selector: `None`, Value: `/common/governance-control-room`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
