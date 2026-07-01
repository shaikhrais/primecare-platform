# SCREEN DATA CONTEXT: ciso_compliance

Below are the database records from `governance.db` used to configure and build the **Chief Information Security Officer (CISO) - CisoComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `157`
* **App ID**: `1`
* **Role ID**: `22`
* **Screen Code**: `ciso_compliance`
* **Screen Name**: `CisoComplianceScreen`
* **Route Path**: `/executive/ciso-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/ciso_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `22`
* **Role Code**: `ciso`
* **Role Name**: `Chief Information Security Officer (CISO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Information Security Officer (CISO) personnel to oversee, audit, and coordinate operations related to cisocompliancescreen.`
* **User Story**: `As a Chief Information Security Officer (CISO), I want to access the CisoComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CisoComplianceScreen`
* **Acceptance Criteria**:
- The CisoComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Information Security Officer (CISO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ciso_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `ciso_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `ciso_compliance-content` (Type: layout, Required: 1)
* **cisocompliance_title** -> `cisocompliance-title` (Type: header, Required: 0)
* **cisocompliance_btn_1** -> `cisocompliance-btn-1` (Type: button, Required: 0)
* **cisocompliance_btn_3** -> `cisocompliance-btn-3` (Type: button, Required: 0)
* **cisocompliance_btn_2** -> `cisocompliance-btn-2` (Type: button, Required: 0)
* **cisocompliance_content** -> `cisocompliance-content` (Type: layout, Required: 0)
* **cisocompliance_screen** -> `cisocompliance-screen` (Type: layout, Required: 0)
* **cisocompliance_loading** -> `cisocompliance-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `165` (Required: 1)
* Component ID: `699` (Required: 1)
* Component ID: `1233` (Required: 1)
* Component ID: `2950` (Required: 1)
* Component ID: `2951` (Required: 1)
* Component ID: `2952` (Required: 1)
* Component ID: `2953` (Required: 1)
* Component ID: `2954` (Required: 1)
* Component ID: `2955` (Required: 1)
* Component ID: `2956` (Required: 1)
* Component ID: `2957` (Required: 1)
* Component ID: `2958` (Required: 1)
* Component ID: `2959` (Required: 1)

## 7. API / Data Mapping
* API ID: `4442` (Required: 1)
* API ID: `4443` (Required: 1)
* API ID: `4444` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ciso_compliance_runtime`
* **Test Name**: `CisoComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Ciso Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ciso`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Ciso Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Ciso Compliance`)
5. **check_url** (Selector: `None`, Value: `/executive/ciso-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
