# SCREEN DATA CONTEXT: local_marketing_manager_compliance

Below are the database records from `governance.db` used to configure and build the **Local Marketing Manager - LocalMarketingManagerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `208`
* **App ID**: `1`
* **Role ID**: `39`
* **Screen Code**: `local_marketing_manager_compliance`
* **Screen Name**: `LocalMarketingManagerComplianceScreen`
* **Route Path**: `/management/local-marketing-manager-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/local_marketing_manager_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `39`
* **Role Code**: `local_marketing`
* **Role Name**: `Local Marketing Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Local Marketing Manager personnel to oversee, audit, and coordinate operations related to localmarketingmanagercompliancescreen.`
* **User Story**: `As a Local Marketing Manager, I want to access the LocalMarketingManagerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `LocalMarketingManagerComplianceScreen`
* **Acceptance Criteria**:
- The LocalMarketingManagerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Local Marketing Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `local_marketing_manager_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `local_marketing_manager_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `local_marketing_manager_compliance-content` (Type: layout, Required: 1)
* **localmarketingmanagercompliance_title** -> `localmarketingmanagercompliance-title` (Type: header, Required: 0)
* **localmarketingmanagercompliance_screen** -> `localmarketingmanagercompliance-screen` (Type: layout, Required: 0)
* **localmarketingmanagercompliance_content** -> `localmarketingmanagercompliance-content` (Type: layout, Required: 0)
* **localmarketingmanagercompliance_btn_2** -> `localmarketingmanagercompliance-btn-2` (Type: button, Required: 0)
* **localmarketingmanagercompliance_btn_1** -> `localmarketingmanagercompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `216` (Required: 1)
* Component ID: `750` (Required: 1)
* Component ID: `1284` (Required: 1)
* Component ID: `3433` (Required: 1)
* Component ID: `3434` (Required: 1)
* Component ID: `3435` (Required: 1)
* Component ID: `3436` (Required: 1)
* Component ID: `3437` (Required: 1)
* Component ID: `3438` (Required: 1)
* Component ID: `3439` (Required: 1)
* Component ID: `3440` (Required: 1)
* Component ID: `3441` (Required: 1)
* Component ID: `3442` (Required: 1)

## 7. API / Data Mapping
* API ID: `4497` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `local_marketing_manager_compliance_runtime`
* **Test Name**: `LocalMarketingManagerComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Local Marketing Manager Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `local_marketing`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Local Marketing Manager Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Local Marketing Manager Compliance`)
5. **check_url** (Selector: `None`, Value: `/management/local-marketing-manager-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
