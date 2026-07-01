# SCREEN DATA CONTEXT: dynamic_compliance

Below are the database records from `governance.db` used to configure and build the **Dynamic Screen Viewer - DynamicScreenComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `105`
* **App ID**: `1`
* **Role ID**: `16`
* **Screen Code**: `dynamic_compliance`
* **Screen Name**: `DynamicScreenComplianceScreen`
* **Route Path**: `/common/dynamic-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/dynamic_screen_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `16`
* **Role Code**: `dynamic`
* **Role Name**: `Dynamic Screen Viewer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Dynamic Screen Viewer personnel to oversee, audit, and coordinate operations related to dynamicscreencompliancescreen.`
* **User Story**: `As a Dynamic Screen Viewer, I want to access the DynamicScreenComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `DynamicScreenComplianceScreen`
* **Acceptance Criteria**:
- The DynamicScreenComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Dynamic Screen Viewer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `dynamic_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `dynamic_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `dynamic_compliance-content` (Type: layout, Required: 1)
* **dynamiccompliance_screen** -> `dynamiccompliance-screen` (Type: layout, Required: 0)
* **dynamiccompliance_content** -> `dynamiccompliance-content` (Type: layout, Required: 0)
* **dynamiccompliance_btn_3** -> `dynamiccompliance-btn-3` (Type: button, Required: 0)
* **dynamiccompliance_title** -> `dynamiccompliance-title` (Type: header, Required: 0)
* **dynamiccompliance_loading** -> `dynamiccompliance-loading` (Type: loading, Required: 0)
* **dynamiccompliance_btn_1** -> `dynamiccompliance-btn-1` (Type: button, Required: 0)
* **dynamiccompliance_btn_2** -> `dynamiccompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `113` (Required: 1)
* Component ID: `647` (Required: 1)
* Component ID: `1181` (Required: 1)
* Component ID: `2516` (Required: 1)
* Component ID: `2517` (Required: 1)
* Component ID: `2518` (Required: 1)
* Component ID: `2519` (Required: 1)
* Component ID: `2520` (Required: 1)
* Component ID: `2521` (Required: 1)
* Component ID: `2522` (Required: 1)
* Component ID: `2523` (Required: 1)
* Component ID: `2524` (Required: 1)
* Component ID: `2525` (Required: 1)

## 7. API / Data Mapping
* API ID: `4382` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `dynamic_compliance_runtime`
* **Test Name**: `DynamicScreenComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Dynamic Screen Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `dynamic`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Dynamic Screen Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Dynamic Screen Compliance`)
5. **check_url** (Selector: `None`, Value: `/common/dynamic-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
