# SCREEN DATA CONTEXT: portal_compliance

Below are the database records from `governance.db` used to configure and build the **Portal User - PortalComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `132`
* **App ID**: `1`
* **Role ID**: `14`
* **Screen Code**: `portal_compliance`
* **Screen Name**: `PortalComplianceScreen`
* **Route Path**: `/common/portal-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/portal_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `14`
* **Role Code**: `portal`
* **Role Name**: `Portal User`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Portal User personnel to oversee, audit, and coordinate operations related to portalcompliancescreen.`
* **User Story**: `As a Portal User, I want to access the PortalComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PortalComplianceScreen`
* **Acceptance Criteria**:
- The PortalComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Portal User access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `portal_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `portal_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `portal_compliance-content` (Type: layout, Required: 1)
* **portalcompliance_screen** -> `portalcompliance-screen` (Type: layout, Required: 0)
* **portalcompliance_title** -> `portalcompliance-title` (Type: header, Required: 0)
* **portalcompliance_btn_4** -> `portalcompliance-btn-4` (Type: button, Required: 0)
* **portalcompliance_btn_1** -> `portalcompliance-btn-1` (Type: button, Required: 0)
* **portalcompliance_btn_3** -> `portalcompliance-btn-3` (Type: button, Required: 0)
* **portalcompliance_loading** -> `portalcompliance-loading` (Type: loading, Required: 0)
* **portalcompliance_btn_2** -> `portalcompliance-btn-2` (Type: button, Required: 0)
* **portalcompliance_btn_5** -> `portalcompliance-btn-5` (Type: button, Required: 0)
* **portalcompliance_content** -> `portalcompliance-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `140` (Required: 1)
* Component ID: `674` (Required: 1)
* Component ID: `1208` (Required: 1)
* Component ID: `2721` (Required: 1)
* Component ID: `2722` (Required: 1)
* Component ID: `2723` (Required: 1)
* Component ID: `2724` (Required: 1)
* Component ID: `2725` (Required: 1)
* Component ID: `2726` (Required: 1)
* Component ID: `2727` (Required: 1)
* Component ID: `2728` (Required: 1)
* Component ID: `2729` (Required: 1)
* Component ID: `2730` (Required: 1)
* Component ID: `2731` (Required: 1)
* Component ID: `2732` (Required: 1)
* Component ID: `2733` (Required: 1)

## 7. API / Data Mapping
* API ID: `4415` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `portal_compliance_runtime`
* **Test Name**: `PortalComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Portal Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `portal`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Portal Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Portal Compliance`)
5. **check_url** (Selector: `None`, Value: `/common/portal-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
