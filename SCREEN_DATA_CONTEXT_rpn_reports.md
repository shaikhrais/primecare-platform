# SCREEN DATA CONTEXT: rpn_reports

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `375`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `rpn_reports`
* **Screen Name**: `RpnReportsScreen`
* **Route Path**: `/offices/clinical/roles/rpn/rpn-reports`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_reports_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `55`
* **Role Code**: `rpn`
* **Role Name**: `Registered Practical Nurse (RPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpnreportsscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnReportsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnReportsScreen`
* **Acceptance Criteria**:
- The RpnReportsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_reports-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_reports-content` (Type: layout, Required: 1)
* **rpnreports_title** -> `rpnreports-title` (Type: header, Required: 0)
* **rpnreports_loading** -> `rpnreports-loading` (Type: loading, Required: 0)
* **rpnreports_btn_3** -> `rpnreports-btn-3` (Type: button, Required: 0)
* **rpnreports_btn_2** -> `rpnreports-btn-2` (Type: button, Required: 0)
* **rpnreports_screen** -> `rpnreports-screen` (Type: layout, Required: 0)
* **rpnreports_btn_1** -> `rpnreports-btn-1` (Type: button, Required: 0)
* **rpnreports_content** -> `rpnreports-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `381` (Required: 1)
* Component ID: `915` (Required: 1)
* Component ID: `1449` (Required: 1)
* Component ID: `4924` (Required: 1)
* Component ID: `4925` (Required: 1)
* Component ID: `4926` (Required: 1)
* Component ID: `4927` (Required: 1)
* Component ID: `4928` (Required: 1)
* Component ID: `4929` (Required: 1)
* Component ID: `4930` (Required: 1)
* Component ID: `4931` (Required: 1)
* Component ID: `4932` (Required: 1)
* Component ID: `4933` (Required: 1)

## 7. API / Data Mapping
* API ID: `4752` (Required: 1)
* API ID: `4753` (Required: 1)
* API ID: `4754` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_reports_runtime`
* **Test Name**: `RpnReportsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rpn Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Rpn Reports`)
4. **click_sidebar_link** (Selector: `None`, Value: `Rpn Reports`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/rpn-reports`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
