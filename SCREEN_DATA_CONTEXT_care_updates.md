# SCREEN DATA CONTEXT: care_updates

Below are the database records from `governance.db` used to configure and build the **Family Member - CareUpdatesScreen** screen.

---

## 1. Screen Record
* **ID**: `574`
* **App ID**: `5`
* **Role ID**: `64`
* **Screen Code**: `care_updates`
* **Screen Name**: `CareUpdatesScreen`
* **Route Path**: `/common/care-updates`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/care_updates_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `64`
* **Role Code**: `family`
* **Role Name**: `Family Member`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Family Member personnel to oversee, audit, and coordinate operations related to careupdatesscreen.`
* **User Story**: `As a Family Member, I want to access the CareUpdatesScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CareUpdatesScreen`
* **Acceptance Criteria**:
- The CareUpdatesScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Family Member access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `care_updates-screen` (Type: layout, Required: 1)
* **page_title** -> `care_updates-title` (Type: header, Required: 1)
* **primary_content** -> `care_updates-content` (Type: layout, Required: 1)
* **careupdates_loading** -> `careupdates-loading` (Type: loading, Required: 0)
* **careupdates_title** -> `careupdates-title` (Type: header, Required: 0)
* **careupdates_content** -> `careupdates-content` (Type: layout, Required: 0)
* **careupdates_btn_1** -> `careupdates-btn-1` (Type: button, Required: 0)
* **careupdates_btn_3** -> `careupdates-btn-3` (Type: button, Required: 0)
* **careupdates_btn_2** -> `careupdates-btn-2` (Type: button, Required: 0)
* **careupdates_screen** -> `careupdates-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `498` (Required: 1)
* Component ID: `1032` (Required: 1)
* Component ID: `1566` (Required: 1)
* Component ID: `6006` (Required: 1)
* Component ID: `6007` (Required: 1)
* Component ID: `6008` (Required: 1)
* Component ID: `6009` (Required: 1)
* Component ID: `6010` (Required: 1)
* Component ID: `6011` (Required: 1)

## 7. API / Data Mapping
* API ID: `4920` (Required: 1)
* API ID: `4921` (Required: 1)
* API ID: `4922` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `care_updates_runtime`
* **Test Name**: `CareUpdatesScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Care Updates`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `family`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Care Updates`)
4. **click_sidebar_link** (Selector: `None`, Value: `Care Updates`)
5. **check_url** (Selector: `None`, Value: `/common/care-updates`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
