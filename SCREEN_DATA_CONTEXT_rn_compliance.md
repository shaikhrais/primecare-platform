# SCREEN DATA CONTEXT: rn_compliance

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `242`
* **App ID**: `1`
* **Role ID**: `8`
* **Screen Code**: `rn_compliance`
* **Screen Name**: `RnComplianceScreen`
* **Route Path**: `/offices/clinical/roles/rn/rn-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `8`
* **Role Code**: `rn`
* **Role Name**: `Registered Nurse (RN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rncompliancescreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnComplianceScreen`
* **Acceptance Criteria**:
- The RnComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `rn_compliance-content` (Type: layout, Required: 1)
* **rncompliance_btn_2** -> `rncompliance-btn-2` (Type: button, Required: 0)
* **rncompliance_content** -> `rncompliance-content` (Type: layout, Required: 0)
* **rncompliance_btn_1** -> `rncompliance-btn-1` (Type: button, Required: 0)
* **rncompliance_screen** -> `rncompliance-screen` (Type: layout, Required: 0)
* **rncompliance_loading** -> `rncompliance-loading` (Type: loading, Required: 0)
* **rncompliance_btn_3** -> `rncompliance-btn-3` (Type: button, Required: 0)
* **rncompliance_title** -> `rncompliance-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `250` (Required: 1)
* Component ID: `784` (Required: 1)
* Component ID: `1318` (Required: 1)
* Component ID: `3740` (Required: 1)
* Component ID: `3741` (Required: 1)
* Component ID: `3742` (Required: 1)
* Component ID: `3743` (Required: 1)
* Component ID: `3744` (Required: 1)
* Component ID: `3745` (Required: 1)
* Component ID: `3746` (Required: 1)
* Component ID: `3747` (Required: 1)
* Component ID: `3748` (Required: 1)
* Component ID: `3749` (Required: 1)

## 7. API / Data Mapping
* API ID: `4545` (Required: 1)
* API ID: `4546` (Required: 1)
* API ID: `4547` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_compliance_runtime`
* **Test Name**: `RnComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RN Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RN Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `RN Compliance`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rn/rn-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
