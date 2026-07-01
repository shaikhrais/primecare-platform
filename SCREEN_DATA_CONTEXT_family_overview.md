# SCREEN DATA CONTEXT: family_overview

Below are the database records from `governance.db` used to configure and build the **Family Member - FamilyOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `573`
* **App ID**: `5`
* **Role ID**: `64`
* **Screen Code**: `family_overview`
* **Screen Name**: `FamilyOverviewScreen`
* **Route Path**: `/common/family-overview`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/family_overview_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `64`
* **Role Code**: `family`
* **Role Name**: `Family Member`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Family Member personnel to oversee, audit, and coordinate operations related to familyoverviewscreen.`
* **User Story**: `As a Family Member, I want to access the FamilyOverviewScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FamilyOverviewScreen`
* **Acceptance Criteria**:
- The FamilyOverviewScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Family Member access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `family_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `family_overview-title` (Type: header, Required: 1)
* **primary_content** -> `family_overview-content` (Type: layout, Required: 1)
* **familyoverview_content** -> `familyoverview-content` (Type: layout, Required: 0)
* **familyoverview_screen** -> `familyoverview-screen` (Type: layout, Required: 0)
* **familyoverview_btn_1** -> `familyoverview-btn-1` (Type: button, Required: 0)
* **familyoverview_btn_2** -> `familyoverview-btn-2` (Type: button, Required: 0)
* **familyoverview_btn_3** -> `familyoverview-btn-3` (Type: button, Required: 0)
* **familyoverview_title** -> `familyoverview-title` (Type: header, Required: 0)
* **familyoverview_loading** -> `familyoverview-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `497` (Required: 1)
* Component ID: `1031` (Required: 1)
* Component ID: `1565` (Required: 1)
* Component ID: `6000` (Required: 1)
* Component ID: `6001` (Required: 1)
* Component ID: `6002` (Required: 1)
* Component ID: `6003` (Required: 1)
* Component ID: `6004` (Required: 1)
* Component ID: `6005` (Required: 1)

## 7. API / Data Mapping
* API ID: `4919` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `family_overview_runtime`
* **Test Name**: `FamilyOverviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Family Overview`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `family`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Family Overview`)
4. **click_sidebar_link** (Selector: `None`, Value: `Family Overview`)
5. **check_url** (Selector: `None`, Value: `/common/family-overview`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
