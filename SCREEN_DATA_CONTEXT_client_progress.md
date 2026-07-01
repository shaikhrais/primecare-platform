# SCREEN DATA CONTEXT: client_progress

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - ClientProgressScreen** screen.

---

## 1. Screen Record
* **ID**: `544`
* **App ID**: `5`
* **Role ID**: `3`
* **Screen Code**: `client_progress`
* **Screen Name**: `ClientProgressScreen`
* **Route Path**: `/offices/clinical/roles/rmt/client-progress`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/client_progress_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to clientprogressscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the ClientProgressScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClientProgressScreen`
* **Acceptance Criteria**:
- The ClientProgressScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `client_progress-screen` (Type: layout, Required: 1)
* **page_title** -> `client_progress-title` (Type: header, Required: 1)
* **primary_content** -> `client_progress-content` (Type: layout, Required: 1)
* **clientprogress_loading** -> `clientprogress-loading` (Type: loading, Required: 0)
* **clientprogress_screen** -> `clientprogress-screen` (Type: layout, Required: 0)
* **clientprogress_btn_3** -> `clientprogress-btn-3` (Type: button, Required: 0)
* **clientprogress_content** -> `clientprogress-content` (Type: layout, Required: 0)
* **clientprogress_btn_1** -> `clientprogress-btn-1` (Type: button, Required: 0)
* **clientprogress_btn_2** -> `clientprogress-btn-2` (Type: button, Required: 0)
* **clientprogress_title** -> `clientprogress-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `468` (Required: 1)
* Component ID: `1002` (Required: 1)
* Component ID: `1536` (Required: 1)
* Component ID: `5757` (Required: 1)
* Component ID: `5758` (Required: 1)
* Component ID: `5759` (Required: 1)
* Component ID: `5760` (Required: 1)
* Component ID: `5761` (Required: 1)
* Component ID: `5762` (Required: 1)
* Component ID: `5763` (Required: 1)
* Component ID: `5764` (Required: 1)
* Component ID: `5765` (Required: 1)
* Component ID: `5766` (Required: 1)

## 7. API / Data Mapping
* API ID: `4877` (Required: 1)
* API ID: `4878` (Required: 1)
* API ID: `4879` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `client_progress_runtime`
* **Test Name**: `ClientProgressScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Client Progress`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Client Progress`)
4. **click_sidebar_link** (Selector: `None`, Value: `Client Progress`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/client-progress`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
