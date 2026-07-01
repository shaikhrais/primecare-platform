# SCREEN DATA CONTEXT: enterprise_health

Below are the database records from `governance.db` used to configure and build the **Chief Executive Officer (CEO) - EnterpriseHealthScreen** screen.

---

## 1. Screen Record
* **ID**: `466`
* **App ID**: `7`
* **Role ID**: `20`
* **Screen Code**: `enterprise_health`
* **Screen Name**: `EnterpriseHealthScreen`
* **Route Path**: `/executive/enterprise-health`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/enterprise_health_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `20`
* **Role Code**: `ceo`
* **Role Name**: `Chief Executive Officer (CEO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Executive Officer (CEO) personnel to oversee, audit, and coordinate operations related to enterprisehealthscreen.`
* **User Story**: `As a Chief Executive Officer (CEO), I want to access the EnterpriseHealthScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `EnterpriseHealthScreen`
* **Acceptance Criteria**:
- The EnterpriseHealthScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Executive Officer (CEO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `enterprise_health-screen` (Type: layout, Required: 1)
* **page_title** -> `enterprise_health-title` (Type: header, Required: 1)
* **primary_content** -> `enterprise_health-content` (Type: layout, Required: 1)
* **enterprisehealth_content** -> `enterprisehealth-content` (Type: layout, Required: 0)
* **enterprisehealth_btn_3** -> `enterprisehealth-btn-3` (Type: button, Required: 0)
* **enterprisehealth_btn_1** -> `enterprisehealth-btn-1` (Type: button, Required: 0)
* **enterprisehealth_title** -> `enterprisehealth-title` (Type: header, Required: 0)
* **enterprisehealth_screen** -> `enterprisehealth-screen` (Type: layout, Required: 0)
* **enterprisehealth_loading** -> `enterprisehealth-loading` (Type: loading, Required: 0)
* **enterprisehealth_btn_2** -> `enterprisehealth-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `395` (Required: 1)
* Component ID: `929` (Required: 1)
* Component ID: `1463` (Required: 1)
* Component ID: `5046` (Required: 1)
* Component ID: `5047` (Required: 1)
* Component ID: `5048` (Required: 1)
* Component ID: `5049` (Required: 1)
* Component ID: `5050` (Required: 1)
* Component ID: `5051` (Required: 1)
* Component ID: `5052` (Required: 1)
* Component ID: `5053` (Required: 1)
* Component ID: `5054` (Required: 1)
* Component ID: `5055` (Required: 1)

## 7. API / Data Mapping
* API ID: `4782` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `enterprise_health_runtime`
* **Test Name**: `EnterpriseHealthScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Enterprise Health`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ceo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Enterprise Health`)
4. **click_sidebar_link** (Selector: `None`, Value: `Enterprise Health`)
5. **check_url** (Selector: `None`, Value: `/executive/enterprise-health`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
