# SCREEN DATA CONTEXT: finance_director_compliance

Below are the database records from `governance.db` used to configure and build the **Finance Director - FinanceDirectorComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `169`
* **App ID**: `1`
* **Role ID**: `26`
* **Screen Code**: `finance_director_compliance`
* **Screen Name**: `FinanceDirectorComplianceScreen`
* **Route Path**: `/executive/finance-director-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/finance_director_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `26`
* **Role Code**: `finance_director`
* **Role Name**: `Finance Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Finance Director personnel to oversee, audit, and coordinate operations related to financedirectorcompliancescreen.`
* **User Story**: `As a Finance Director, I want to access the FinanceDirectorComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FinanceDirectorComplianceScreen`
* **Acceptance Criteria**:
- The FinanceDirectorComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Finance Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `finance_director_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `finance_director_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `finance_director_compliance-content` (Type: layout, Required: 1)
* **financedirectorcompliance_title** -> `financedirectorcompliance-title` (Type: header, Required: 0)
* **financedirectorcompliance_btn_2** -> `financedirectorcompliance-btn-2` (Type: button, Required: 0)
* **financedirectorcompliance_screen** -> `financedirectorcompliance-screen` (Type: layout, Required: 0)
* **financedirectorcompliance_btn_3** -> `financedirectorcompliance-btn-3` (Type: button, Required: 0)
* **financedirectorcompliance_content** -> `financedirectorcompliance-content` (Type: layout, Required: 0)
* **financedirectorcompliance_btn_4** -> `financedirectorcompliance-btn-4` (Type: button, Required: 0)
* **financedirectorcompliance_btn_5** -> `financedirectorcompliance-btn-5` (Type: button, Required: 0)
* **financedirectorcompliance_btn_1** -> `financedirectorcompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `177` (Required: 1)
* Component ID: `711` (Required: 1)
* Component ID: `1245` (Required: 1)
* Component ID: `3070` (Required: 1)
* Component ID: `3071` (Required: 1)
* Component ID: `3072` (Required: 1)
* Component ID: `3073` (Required: 1)
* Component ID: `3074` (Required: 1)
* Component ID: `3075` (Required: 1)
* Component ID: `3076` (Required: 1)
* Component ID: `3077` (Required: 1)
* Component ID: `3078` (Required: 1)
* Component ID: `3079` (Required: 1)

## 7. API / Data Mapping
* API ID: `4458` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `finance_director_compliance_runtime`
* **Test Name**: `FinanceDirectorComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Finance Director Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `finance_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Finance Director Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Finance Director Compliance`)
5. **check_url** (Selector: `None`, Value: `/executive/finance-director-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
