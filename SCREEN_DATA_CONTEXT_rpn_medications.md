# SCREEN DATA CONTEXT: rpn_medications

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnMedicationsScreen** screen.

---

## 1. Screen Record
* **ID**: `370`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `rpn_medications`
* **Screen Name**: `RpnMedicationsScreen`
* **Route Path**: `/offices/clinical/roles/rpn/medications`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_medications_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpnmedicationsscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnMedicationsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnMedicationsScreen`
* **Acceptance Criteria**:
- The RpnMedicationsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_medications-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_medications-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_medications-content` (Type: layout, Required: 1)
* **rpnmedications_btn_1** -> `rpnmedications-btn-1` (Type: button, Required: 0)
* **rpnmedications_screen** -> `rpnmedications-screen` (Type: layout, Required: 0)
* **rpnmedications_loading** -> `rpnmedications-loading` (Type: loading, Required: 0)
* **rpnmedications_btn_3** -> `rpnmedications-btn-3` (Type: button, Required: 0)
* **rpnmedications_btn_2** -> `rpnmedications-btn-2` (Type: button, Required: 0)
* **rpnmedications_content** -> `rpnmedications-content` (Type: layout, Required: 0)
* **rpnmedications_title** -> `rpnmedications-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `376` (Required: 1)
* Component ID: `910` (Required: 1)
* Component ID: `1444` (Required: 1)
* Component ID: `4874` (Required: 1)
* Component ID: `4875` (Required: 1)
* Component ID: `4876` (Required: 1)
* Component ID: `4877` (Required: 1)
* Component ID: `4878` (Required: 1)
* Component ID: `4879` (Required: 1)
* Component ID: `4880` (Required: 1)
* Component ID: `4881` (Required: 1)
* Component ID: `4882` (Required: 1)
* Component ID: `4883` (Required: 1)

## 7. API / Data Mapping
* API ID: `4737` (Required: 1)
* API ID: `4738` (Required: 1)
* API ID: `4739` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_medications_runtime`
* **Test Name**: `RpnMedicationsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rpn Medications`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Rpn Medications`)
4. **click_sidebar_link** (Selector: `None`, Value: `Rpn Medications`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/medications`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
