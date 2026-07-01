# SCREEN DATA CONTEXT: shareholder_compliance

Below are the database records from `governance.db` used to configure and build the **Shareholder - ShareholderComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `181`
* **App ID**: `1`
* **Role ID**: `30`
* **Screen Code**: `shareholder_compliance`
* **Screen Name**: `ShareholderComplianceScreen`
* **Route Path**: `/executive/shareholder-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/shareholder_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `30`
* **Role Code**: `shareholder`
* **Role Name**: `Shareholder`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Shareholder personnel to oversee, audit, and coordinate operations related to shareholdercompliancescreen.`
* **User Story**: `As a Shareholder, I want to access the ShareholderComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ShareholderComplianceScreen`
* **Acceptance Criteria**:
- The ShareholderComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shareholder access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `shareholder_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `shareholder_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `shareholder_compliance-content` (Type: layout, Required: 1)
* **shareholdercompliance_btn_4** -> `shareholdercompliance-btn-4` (Type: button, Required: 0)
* **shareholdercompliance_btn_5** -> `shareholdercompliance-btn-5` (Type: button, Required: 0)
* **shareholdercompliance_title** -> `shareholdercompliance-title` (Type: header, Required: 0)
* **shareholdercompliance_btn_1** -> `shareholdercompliance-btn-1` (Type: button, Required: 0)
* **shareholdercompliance_content** -> `shareholdercompliance-content` (Type: layout, Required: 0)
* **shareholdercompliance_screen** -> `shareholdercompliance-screen` (Type: layout, Required: 0)
* **shareholdercompliance_btn_3** -> `shareholdercompliance-btn-3` (Type: button, Required: 0)
* **shareholdercompliance_btn_2** -> `shareholdercompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `189` (Required: 1)
* Component ID: `723` (Required: 1)
* Component ID: `1257` (Required: 1)
* Component ID: `3186` (Required: 1)
* Component ID: `3187` (Required: 1)
* Component ID: `3188` (Required: 1)
* Component ID: `3189` (Required: 1)
* Component ID: `3190` (Required: 1)
* Component ID: `3191` (Required: 1)

## 7. API / Data Mapping
* API ID: `4470` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `shareholder_compliance_runtime`
* **Test Name**: `ShareholderComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Shareholder Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `shareholder`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Shareholder Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Shareholder Compliance`)
5. **check_url** (Selector: `None`, Value: `/executive/shareholder-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
