# SCREEN DATA CONTEXT: chiropractor_compliance

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `93`
* **App ID**: `1`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_compliance`
* **Screen Name**: `ChiropractorComplianceScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/chiropractor_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorcompliancescreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorComplianceScreen`
* **Acceptance Criteria**:
- The ChiropractorComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_compliance-content` (Type: layout, Required: 1)
* **chiropractorcompliance_screen** -> `chiropractorcompliance-screen` (Type: layout, Required: 0)
* **chiropractorcompliance_content** -> `chiropractorcompliance-content` (Type: layout, Required: 0)
* **chiropractorcompliance_title** -> `chiropractorcompliance-title` (Type: header, Required: 0)
* **chiropractorcompliance_btn_2** -> `chiropractorcompliance-btn-2` (Type: button, Required: 0)
* **chiropractorcompliance_btn_3** -> `chiropractorcompliance-btn-3` (Type: button, Required: 0)
* **chiropractorcompliance_btn_1** -> `chiropractorcompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `101` (Required: 1)
* Component ID: `635` (Required: 1)
* Component ID: `1169` (Required: 1)
* Component ID: `2417` (Required: 1)
* Component ID: `2418` (Required: 1)
* Component ID: `2419` (Required: 1)
* Component ID: `2420` (Required: 1)
* Component ID: `2421` (Required: 1)
* Component ID: `2422` (Required: 1)
* Component ID: `2423` (Required: 1)
* Component ID: `2424` (Required: 1)

## 7. API / Data Mapping
* API ID: `4370` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_compliance_runtime`
* **Test Name**: `ChiropractorComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Chiropractor Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Chiropractor Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Chiropractor Compliance`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
