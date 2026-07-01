# SCREEN DATA CONTEXT: staff_progress

Below are the database records from `governance.db` used to configure and build the **Training Coordinator - StaffProgressScreen** screen.

---

## 1. Screen Record
* **ID**: `564`
* **App ID**: `5`
* **Role ID**: `62`
* **Screen Code**: `staff_progress`
* **Screen Name**: `StaffProgressScreen`
* **Route Path**: `/staff/staff-progress`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/staff_progress_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `62`
* **Role Code**: `training_coordinator`
* **Role Name**: `Training Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Training Coordinator personnel to oversee, audit, and coordinate operations related to staffprogressscreen.`
* **User Story**: `As a Training Coordinator, I want to access the StaffProgressScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `StaffProgressScreen`
* **Acceptance Criteria**:
- The StaffProgressScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `staff_progress-screen` (Type: layout, Required: 1)
* **page_title** -> `staff_progress-title` (Type: header, Required: 1)
* **primary_content** -> `staff_progress-content` (Type: layout, Required: 1)
* **staffprogress_btn_1** -> `staffprogress-btn-1` (Type: button, Required: 0)
* **staffprogress_btn_2** -> `staffprogress-btn-2` (Type: button, Required: 0)
* **staffprogress_title** -> `staffprogress-title` (Type: header, Required: 0)
* **staffprogress_btn_5** -> `staffprogress-btn-5` (Type: button, Required: 0)
* **staffprogress_btn_3** -> `staffprogress-btn-3` (Type: button, Required: 0)
* **staffprogress_btn_4** -> `staffprogress-btn-4` (Type: button, Required: 0)
* **staffprogress_screen** -> `staffprogress-screen` (Type: layout, Required: 0)
* **staffprogress_loading** -> `staffprogress-loading` (Type: loading, Required: 0)
* **staffprogress_content** -> `staffprogress-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `488` (Required: 1)
* Component ID: `1022` (Required: 1)
* Component ID: `1556` (Required: 1)
* Component ID: `5936` (Required: 1)
* Component ID: `5937` (Required: 1)
* Component ID: `5938` (Required: 1)
* Component ID: `5939` (Required: 1)
* Component ID: `5940` (Required: 1)
* Component ID: `5941` (Required: 1)
* Component ID: `5942` (Required: 1)
* Component ID: `5943` (Required: 1)
* Component ID: `5944` (Required: 1)
* Component ID: `5945` (Required: 1)

## 7. API / Data Mapping
* API ID: `4911` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `staff_progress_runtime`
* **Test Name**: `StaffProgressScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Staff Progress`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training_coordinator`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Staff Progress`)
4. **click_sidebar_link** (Selector: `None`, Value: `Staff Progress`)
5. **check_url** (Selector: `None`, Value: `/staff/staff-progress`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
