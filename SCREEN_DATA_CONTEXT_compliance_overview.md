# SCREEN DATA CONTEXT: compliance_overview

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - ComplianceOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `507`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `compliance_overview`
* **Screen Name**: `ComplianceOverviewScreen`
* **Route Path**: `/executive/compliance-overview`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/compliance_overview_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `9`
* **App Code**: `fr`
* **App Name**: `Primecare Franchise`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to complianceoverviewscreen.`
* **User Story**: `As a Franchise Owner, I want to access the ComplianceOverviewScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ComplianceOverviewScreen`
* **Acceptance Criteria**:
- The ComplianceOverviewScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_overview-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_overview-content` (Type: layout, Required: 1)
* **complianceoverview_screen** -> `complianceoverview-screen` (Type: layout, Required: 0)
* **complianceoverview_content** -> `complianceoverview-content` (Type: layout, Required: 0)
* **complianceoverview_btn_1** -> `complianceoverview-btn-1` (Type: button, Required: 0)
* **complianceoverview_btn_2** -> `complianceoverview-btn-2` (Type: button, Required: 0)
* **complianceoverview_btn_3** -> `complianceoverview-btn-3` (Type: button, Required: 0)
* **complianceoverview_title** -> `complianceoverview-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `436` (Required: 1)
* Component ID: `970` (Required: 1)
* Component ID: `1504` (Required: 1)
* Component ID: `5450` (Required: 1)
* Component ID: `5451` (Required: 1)
* Component ID: `5452` (Required: 1)
* Component ID: `5453` (Required: 1)
* Component ID: `5454` (Required: 1)
* Component ID: `5455` (Required: 1)
* Component ID: `5456` (Required: 1)
* Component ID: `5457` (Required: 1)
* Component ID: `5458` (Required: 1)

## 7. API / Data Mapping
* API ID: `4802` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_overview_runtime`
* **Test Name**: `ComplianceOverviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Overview`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Compliance Overview`)
4. **click_sidebar_link** (Selector: `None`, Value: `Compliance Overview`)
5. **check_url** (Selector: `None`, Value: `/executive/compliance-overview`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
