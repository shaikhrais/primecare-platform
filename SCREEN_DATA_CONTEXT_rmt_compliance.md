# SCREEN DATA CONTEXT: rmt_compliance

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `77`
* **App ID**: `1`
* **Role ID**: `3`
* **Screen Code**: `rmt_compliance`
* **Screen Name**: `RmtComplianceScreen`
* **Route Path**: `/offices/clinical/roles/rmt/compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtcompliancescreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtComplianceScreen`
* **Acceptance Criteria**:
- The RmtComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_compliance-content` (Type: layout, Required: 1)
* **rmtcompliance_content** -> `rmtcompliance-content` (Type: layout, Required: 0)
* **rmtcompliance_screen** -> `rmtcompliance-screen` (Type: layout, Required: 0)
* **rmtcompliance_btn_3** -> `rmtcompliance-btn-3` (Type: button, Required: 0)
* **rmtcompliance_loading** -> `rmtcompliance-loading` (Type: loading, Required: 0)
* **rmtcompliance_btn_1** -> `rmtcompliance-btn-1` (Type: button, Required: 0)
* **rmtcompliance_btn_2** -> `rmtcompliance-btn-2` (Type: button, Required: 0)
* **rmtcompliance_title** -> `rmtcompliance-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `85` (Required: 1)
* Component ID: `619` (Required: 1)
* Component ID: `1153` (Required: 1)
* Component ID: `2265` (Required: 1)
* Component ID: `2266` (Required: 1)
* Component ID: `2267` (Required: 1)
* Component ID: `2268` (Required: 1)
* Component ID: `2269` (Required: 1)
* Component ID: `2270` (Required: 1)
* Component ID: `2271` (Required: 1)
* Component ID: `2272` (Required: 1)
* Component ID: `2273` (Required: 1)
* Component ID: `2274` (Required: 1)

## 7. API / Data Mapping
* API ID: `4344` (Required: 1)
* API ID: `4345` (Required: 1)
* API ID: `4346` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_compliance_runtime`
* **Test Name**: `RmtComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Compliance`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
