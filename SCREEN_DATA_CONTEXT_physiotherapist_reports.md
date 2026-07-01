# SCREEN DATA CONTEXT: physiotherapist_reports

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `342`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_reports`
* **Screen Name**: `PhysiotherapistReportsScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/reports`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_reports_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistreportsscreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistReportsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistReportsScreen`
* **Acceptance Criteria**:
- The PhysiotherapistReportsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_reports-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_reports-content` (Type: layout, Required: 1)
* **physiotherapistreports_btn_2** -> `physiotherapistreports-btn-2` (Type: button, Required: 0)
* **physiotherapistreports_title** -> `physiotherapistreports-title` (Type: header, Required: 0)
* **physiotherapistreports_content** -> `physiotherapistreports-content` (Type: layout, Required: 0)
* **physiotherapistreports_screen** -> `physiotherapistreports-screen` (Type: layout, Required: 0)
* **physiotherapistreports_btn_3** -> `physiotherapistreports-btn-3` (Type: button, Required: 0)
* **physiotherapistreports_btn_1** -> `physiotherapistreports-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `350` (Required: 1)
* Component ID: `884` (Required: 1)
* Component ID: `1418` (Required: 1)
* Component ID: `4617` (Required: 1)
* Component ID: `4618` (Required: 1)
* Component ID: `4619` (Required: 1)
* Component ID: `4620` (Required: 1)
* Component ID: `4621` (Required: 1)
* Component ID: `4622` (Required: 1)
* Component ID: `4623` (Required: 1)

## 7. API / Data Mapping
* API ID: `4675` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_reports_runtime`
* **Test Name**: `PhysiotherapistReportsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Physiotherapist Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Physiotherapist Reports`)
4. **click_sidebar_link** (Selector: `None`, Value: `Physiotherapist Reports`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/reports`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
