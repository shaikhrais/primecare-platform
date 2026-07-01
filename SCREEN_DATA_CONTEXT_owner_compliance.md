# SCREEN DATA CONTEXT: owner_compliance

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - OwnerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `178`
* **App ID**: `1`
* **Role ID**: `29`
* **Screen Code**: `owner_compliance`
* **Screen Name**: `OwnerComplianceScreen`
* **Route Path**: `/executive/owner-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/owner_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to ownercompliancescreen.`
* **User Story**: `As a Franchise Owner, I want to access the OwnerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OwnerComplianceScreen`
* **Acceptance Criteria**:
- The OwnerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `owner_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `owner_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `owner_compliance-content` (Type: layout, Required: 1)
* **ownercompliance_title** -> `ownercompliance-title` (Type: header, Required: 0)
* **ownercompliance_loading** -> `ownercompliance-loading` (Type: loading, Required: 0)
* **ownercompliance_btn_2** -> `ownercompliance-btn-2` (Type: button, Required: 0)
* **ownercompliance_content** -> `ownercompliance-content` (Type: layout, Required: 0)
* **ownercompliance_btn_1** -> `ownercompliance-btn-1` (Type: button, Required: 0)
* **ownercompliance_btn_3** -> `ownercompliance-btn-3` (Type: button, Required: 0)
* **ownercompliance_screen** -> `ownercompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `186` (Required: 1)
* Component ID: `720` (Required: 1)
* Component ID: `1254` (Required: 1)
* Component ID: `3159` (Required: 1)
* Component ID: `3160` (Required: 1)
* Component ID: `3161` (Required: 1)
* Component ID: `3162` (Required: 1)
* Component ID: `3163` (Required: 1)
* Component ID: `3164` (Required: 1)
* Component ID: `3165` (Required: 1)
* Component ID: `3166` (Required: 1)
* Component ID: `3167` (Required: 1)
* Component ID: `3168` (Required: 1)

## 7. API / Data Mapping
* API ID: `4467` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `owner_compliance_runtime`
* **Test Name**: `OwnerComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Owner Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Owner Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Owner Compliance`)
5. **check_url** (Selector: `None`, Value: `/executive/owner-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
