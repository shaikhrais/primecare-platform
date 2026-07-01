# SCREEN DATA CONTEXT: cto_compliance

Below are the database records from `governance.db` used to configure and build the **Chief Technology Officer (CTO) - CtoComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `163`
* **App ID**: `1`
* **Role ID**: `24`
* **Screen Code**: `cto_compliance`
* **Screen Name**: `CtoComplianceScreen`
* **Route Path**: `/executive/cto-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cto_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `24`
* **Role Code**: `cto`
* **Role Name**: `Chief Technology Officer (CTO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Technology Officer (CTO) personnel to oversee, audit, and coordinate operations related to ctocompliancescreen.`
* **User Story**: `As a Chief Technology Officer (CTO), I want to access the CtoComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CtoComplianceScreen`
* **Acceptance Criteria**:
- The CtoComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Technology Officer (CTO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `cto_compliance-content` (Type: layout, Required: 1)
* **ctocompliance_loading** -> `ctocompliance-loading` (Type: loading, Required: 0)
* **ctocompliance_title** -> `ctocompliance-title` (Type: header, Required: 0)
* **ctocompliance_btn_1** -> `ctocompliance-btn-1` (Type: button, Required: 0)
* **ctocompliance_content** -> `ctocompliance-content` (Type: layout, Required: 0)
* **ctocompliance_btn_2** -> `ctocompliance-btn-2` (Type: button, Required: 0)
* **ctocompliance_btn_3** -> `ctocompliance-btn-3` (Type: button, Required: 0)
* **ctocompliance_screen** -> `ctocompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `171` (Required: 1)
* Component ID: `705` (Required: 1)
* Component ID: `1239` (Required: 1)
* Component ID: `3010` (Required: 1)
* Component ID: `3011` (Required: 1)
* Component ID: `3012` (Required: 1)
* Component ID: `3013` (Required: 1)
* Component ID: `3014` (Required: 1)
* Component ID: `3015` (Required: 1)
* Component ID: `3016` (Required: 1)
* Component ID: `3017` (Required: 1)
* Component ID: `3018` (Required: 1)
* Component ID: `3019` (Required: 1)

## 7. API / Data Mapping
* API ID: `4452` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_compliance_runtime`
* **Test Name**: `CtoComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CTO Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cto`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CTO Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `CTO Compliance`)
5. **check_url** (Selector: `None`, Value: `/executive/cto-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
