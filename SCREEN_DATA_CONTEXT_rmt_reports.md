# SCREEN DATA CONTEXT: rmt_reports

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `359`
* **App ID**: `6`
* **Role ID**: `3`
* **Screen Code**: `rmt_reports`
* **Screen Name**: `RmtReportsScreen`
* **Route Path**: `/offices/clinical/roles/rmt/reports`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_reports_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtreportsscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtReportsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtReportsScreen`
* **Acceptance Criteria**:
- The RmtReportsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_reports-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_reports-content` (Type: layout, Required: 1)
* **rmtreports_btn_3** -> `rmtreports-btn-3` (Type: button, Required: 0)
* **rmtreports_btn_1** -> `rmtreports-btn-1` (Type: button, Required: 0)
* **rmtreports_loading** -> `rmtreports-loading` (Type: loading, Required: 0)
* **rmtreports_screen** -> `rmtreports-screen` (Type: layout, Required: 0)
* **rmtreports_title** -> `rmtreports-title` (Type: header, Required: 0)
* **rmtreports_content** -> `rmtreports-content` (Type: layout, Required: 0)
* **rmtreports_btn_2** -> `rmtreports-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `365` (Required: 1)
* Component ID: `899` (Required: 1)
* Component ID: `1433` (Required: 1)
* Component ID: `4768` (Required: 1)
* Component ID: `4769` (Required: 1)
* Component ID: `4770` (Required: 1)
* Component ID: `4771` (Required: 1)
* Component ID: `4772` (Required: 1)
* Component ID: `4773` (Required: 1)
* Component ID: `4774` (Required: 1)
* Component ID: `4775` (Required: 1)
* Component ID: `4776` (Required: 1)
* Component ID: `4777` (Required: 1)

## 7. API / Data Mapping
* API ID: `4704` (Required: 1)
* API ID: `4705` (Required: 1)
* API ID: `4706` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_reports_runtime`
* **Test Name**: `RmtReportsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Reports`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Reports`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/reports`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
