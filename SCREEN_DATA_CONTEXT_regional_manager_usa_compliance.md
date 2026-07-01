# SCREEN DATA CONTEXT: regional_manager_usa_compliance

Below are the database records from `governance.db` used to configure and build the **Regional Manager USA - RegionalManagerUsaComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `220`
* **App ID**: `1`
* **Role ID**: `43`
* **Screen Code**: `regional_manager_usa_compliance`
* **Screen Name**: `RegionalManagerUsaComplianceScreen`
* **Route Path**: `/management/regional-manager-usa-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/regional_manager_usa_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `43`
* **Role Code**: `regional_manager_usa`
* **Role Name**: `Regional Manager USA`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Regional Manager USA personnel to oversee, audit, and coordinate operations related to regionalmanagerusacompliancescreen.`
* **User Story**: `As a Regional Manager USA, I want to access the RegionalManagerUsaComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RegionalManagerUsaComplianceScreen`
* **Acceptance Criteria**:
- The RegionalManagerUsaComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Regional Manager USA access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_manager_usa_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_manager_usa_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `regional_manager_usa_compliance-content` (Type: layout, Required: 1)
* **regionalmanagerusacompliance_btn_1** -> `regionalmanagerusacompliance-btn-1` (Type: button, Required: 0)
* **regionalmanagerusacompliance_btn_3** -> `regionalmanagerusacompliance-btn-3` (Type: button, Required: 0)
* **regionalmanagerusacompliance_btn_2** -> `regionalmanagerusacompliance-btn-2` (Type: button, Required: 0)
* **regionalmanagerusacompliance_title** -> `regionalmanagerusacompliance-title` (Type: header, Required: 0)
* **regionalmanagerusacompliance_screen** -> `regionalmanagerusacompliance-screen` (Type: layout, Required: 0)
* **regionalmanagerusacompliance_content** -> `regionalmanagerusacompliance-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `228` (Required: 1)
* Component ID: `762` (Required: 1)
* Component ID: `1296` (Required: 1)
* Component ID: `3545` (Required: 1)
* Component ID: `3546` (Required: 1)
* Component ID: `3547` (Required: 1)
* Component ID: `3548` (Required: 1)
* Component ID: `3549` (Required: 1)
* Component ID: `3550` (Required: 1)
* Component ID: `3551` (Required: 1)
* Component ID: `3552` (Required: 1)

## 7. API / Data Mapping
* API ID: `4509` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_manager_usa_compliance_runtime`
* **Test Name**: `RegionalManagerUsaComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Regional Manager Usa Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `regional_manager_usa`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Regional Manager Usa Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Regional Manager Usa Compliance`)
5. **check_url** (Selector: `None`, Value: `/management/regional-manager-usa-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
