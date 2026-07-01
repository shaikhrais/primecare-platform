# SCREEN DATA CONTEXT: cx_director_compliance

Below are the database records from `governance.db` used to configure and build the **CX Director - CxDirectorComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `166`
* **App ID**: `1`
* **Role ID**: `25`
* **Screen Code**: `cx_director_compliance`
* **Screen Name**: `CxDirectorComplianceScreen`
* **Route Path**: `/executive/cx-director-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cx_director_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `25`
* **Role Code**: `cx_director`
* **Role Name**: `CX Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable CX Director personnel to oversee, audit, and coordinate operations related to cxdirectorcompliancescreen.`
* **User Story**: `As a CX Director, I want to access the CxDirectorComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CxDirectorComplianceScreen`
* **Acceptance Criteria**:
- The CxDirectorComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only CX Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cx_director_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `cx_director_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `cx_director_compliance-content` (Type: layout, Required: 1)
* **cxdirectorcompliance_btn_3** -> `cxdirectorcompliance-btn-3` (Type: button, Required: 0)
* **cxdirectorcompliance_content** -> `cxdirectorcompliance-content` (Type: layout, Required: 0)
* **cxdirectorcompliance_btn_4** -> `cxdirectorcompliance-btn-4` (Type: button, Required: 0)
* **cxdirectorcompliance_btn_2** -> `cxdirectorcompliance-btn-2` (Type: button, Required: 0)
* **cxdirectorcompliance_screen** -> `cxdirectorcompliance-screen` (Type: layout, Required: 0)
* **cxdirectorcompliance_title** -> `cxdirectorcompliance-title` (Type: header, Required: 0)
* **cxdirectorcompliance_btn_1** -> `cxdirectorcompliance-btn-1` (Type: button, Required: 0)
* **cxdirectorcompliance_btn_5** -> `cxdirectorcompliance-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `174` (Required: 1)
* Component ID: `708` (Required: 1)
* Component ID: `1242` (Required: 1)
* Component ID: `3040` (Required: 1)
* Component ID: `3041` (Required: 1)
* Component ID: `3042` (Required: 1)
* Component ID: `3043` (Required: 1)
* Component ID: `3044` (Required: 1)
* Component ID: `3045` (Required: 1)
* Component ID: `3046` (Required: 1)
* Component ID: `3047` (Required: 1)
* Component ID: `3048` (Required: 1)
* Component ID: `3049` (Required: 1)

## 7. API / Data Mapping
* API ID: `4455` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cx_director_compliance_runtime`
* **Test Name**: `CxDirectorComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CX Director Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cx_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CX Director Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `CX Director Compliance`)
5. **check_url** (Selector: `None`, Value: `/executive/cx-director-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
