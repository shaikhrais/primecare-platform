# SCREEN DATA CONTEXT: vitals_entry

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - VitalsEntryScreen** screen.

---

## 1. Screen Record
* **ID**: `535`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `vitals_entry`
* **Screen Name**: `VitalsEntryScreen`
* **Route Path**: `/offices/clinical/roles/psw/vitals-entry`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/vitals_entry_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to vitalsentryscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the VitalsEntryScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `VitalsEntryScreen`
* **Acceptance Criteria**:
- The VitalsEntryScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `vitals_entry-screen` (Type: layout, Required: 1)
* **page_title** -> `vitals_entry-title` (Type: header, Required: 1)
* **primary_content** -> `vitals_entry-content` (Type: layout, Required: 1)
* **vitalsentry_screen** -> `vitalsentry-screen` (Type: layout, Required: 0)
* **vitalsentry_loading** -> `vitalsentry-loading` (Type: loading, Required: 0)
* **vitalsentry_btn_3** -> `vitalsentry-btn-3` (Type: button, Required: 0)
* **vitalsentry_title** -> `vitalsentry-title` (Type: header, Required: 0)
* **vitalsentry_btn_1** -> `vitalsentry-btn-1` (Type: button, Required: 0)
* **vitalsentry_content** -> `vitalsentry-content` (Type: layout, Required: 0)
* **vitalsentry_btn_2** -> `vitalsentry-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `462` (Required: 1)
* Component ID: `996` (Required: 1)
* Component ID: `1530` (Required: 1)
* Component ID: `5700` (Required: 1)
* Component ID: `5701` (Required: 1)
* Component ID: `5702` (Required: 1)
* Component ID: `5703` (Required: 1)
* Component ID: `5704` (Required: 1)
* Component ID: `5705` (Required: 1)
* Component ID: `5706` (Required: 1)
* Component ID: `5707` (Required: 1)
* Component ID: `5708` (Required: 1)
* Component ID: `5709` (Required: 1)

## 7. API / Data Mapping
* API ID: `4865` (Required: 1)
* API ID: `4866` (Required: 1)
* API ID: `4867` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `vitals_entry_runtime`
* **Test Name**: `VitalsEntryScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Vitals Entry`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Vitals Entry`)
4. **click_sidebar_link** (Selector: `None`, Value: `Vitals Entry`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/psw/vitals-entry`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
