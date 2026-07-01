# SCREEN DATA CONTEXT: general_manager_compliance

Below are the database records from `governance.db` used to configure and build the **General Manager - GeneralManagerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `196`
* **App ID**: `1`
* **Role ID**: `35`
* **Screen Code**: `general_manager_compliance`
* **Screen Name**: `GeneralManagerComplianceScreen`
* **Route Path**: `/management/general-manager-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/general_manager_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `35`
* **Role Code**: `gm`
* **Role Name**: `General Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable General Manager personnel to oversee, audit, and coordinate operations related to generalmanagercompliancescreen.`
* **User Story**: `As a General Manager, I want to access the GeneralManagerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GeneralManagerComplianceScreen`
* **Acceptance Criteria**:
- The GeneralManagerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only General Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `general_manager_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `general_manager_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `general_manager_compliance-content` (Type: layout, Required: 1)
* **generalmanagercompliance_title** -> `generalmanagercompliance-title` (Type: header, Required: 0)
* **generalmanagercompliance_content** -> `generalmanagercompliance-content` (Type: layout, Required: 0)
* **generalmanagercompliance_btn_5** -> `generalmanagercompliance-btn-5` (Type: button, Required: 0)
* **generalmanagercompliance_btn_1** -> `generalmanagercompliance-btn-1` (Type: button, Required: 0)
* **generalmanagercompliance_btn_3** -> `generalmanagercompliance-btn-3` (Type: button, Required: 0)
* **generalmanagercompliance_btn_4** -> `generalmanagercompliance-btn-4` (Type: button, Required: 0)
* **generalmanagercompliance_btn_2** -> `generalmanagercompliance-btn-2` (Type: button, Required: 0)
* **generalmanagercompliance_screen** -> `generalmanagercompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `204` (Required: 1)
* Component ID: `738` (Required: 1)
* Component ID: `1272` (Required: 1)
* Component ID: `3313` (Required: 1)
* Component ID: `3314` (Required: 1)
* Component ID: `3315` (Required: 1)
* Component ID: `3316` (Required: 1)
* Component ID: `3317` (Required: 1)
* Component ID: `3318` (Required: 1)
* Component ID: `3319` (Required: 1)
* Component ID: `3320` (Required: 1)
* Component ID: `3321` (Required: 1)
* Component ID: `3322` (Required: 1)

## 7. API / Data Mapping
* API ID: `4485` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `general_manager_compliance_runtime`
* **Test Name**: `GeneralManagerComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `General Manager Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `gm`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `General Manager Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `General Manager Compliance`)
5. **check_url** (Selector: `None`, Value: `/management/general-manager-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
