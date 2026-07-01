# SCREEN DATA CONTEXT: psw_vitals_log

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - PswVitalsLogScreen** screen.

---

## 1. Screen Record
* **ID**: `347`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `psw_vitals_log`
* **Screen Name**: `PswVitalsLogScreen`
* **Route Path**: `/offices/clinical/roles/psw/observation-vitals-log`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_vitals_log_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswvitalslogscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswVitalsLogScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswVitalsLogScreen`
* **Acceptance Criteria**:
- The PswVitalsLogScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_vitals_log-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_vitals_log-title` (Type: header, Required: 1)
* **primary_content** -> `psw_vitals_log-content` (Type: layout, Required: 1)
* **pswvitalslog_screen** -> `pswvitalslog-screen` (Type: layout, Required: 0)
* **pswvitalslog_btn_3** -> `pswvitalslog-btn-3` (Type: button, Required: 0)
* **pswvitalslog_btn_2** -> `pswvitalslog-btn-2` (Type: button, Required: 0)
* **pswvitalslog_content** -> `pswvitalslog-content` (Type: layout, Required: 0)
* **pswvitalslog_title** -> `pswvitalslog-title` (Type: header, Required: 0)
* **pswvitalslog_loading** -> `pswvitalslog-loading` (Type: loading, Required: 0)
* **pswvitalslog_btn_1** -> `pswvitalslog-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `354` (Required: 1)
* Component ID: `888` (Required: 1)
* Component ID: `1422` (Required: 1)
* Component ID: `4658` (Required: 1)
* Component ID: `4659` (Required: 1)
* Component ID: `4660` (Required: 1)
* Component ID: `4661` (Required: 1)
* Component ID: `4662` (Required: 1)
* Component ID: `4663` (Required: 1)
* Component ID: `4664` (Required: 1)
* Component ID: `4665` (Required: 1)
* Component ID: `4666` (Required: 1)
* Component ID: `4667` (Required: 1)

## 7. API / Data Mapping
* API ID: `4679` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_vitals_log_runtime`
* **Test Name**: `PswVitalsLogScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `PSW Vitals Log`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `PSW Vitals Log`)
4. **click_sidebar_link** (Selector: `None`, Value: `PSW Vitals Log`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/psw/observation-vitals-log`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
