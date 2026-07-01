# SCREEN DATA CONTEXT: rpn_vitals

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnVitalsScreen** screen.

---

## 1. Screen Record
* **ID**: `371`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `rpn_vitals`
* **Screen Name**: `RpnVitalsScreen`
* **Route Path**: `/offices/clinical/roles/rpn/vitals`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_vitals_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpnvitalsscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnVitalsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnVitalsScreen`
* **Acceptance Criteria**:
- The RpnVitalsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_vitals-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_vitals-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_vitals-content` (Type: layout, Required: 1)
* **rpnvitals_btn_1** -> `rpnvitals-btn-1` (Type: button, Required: 0)
* **rpnvitals_btn_3** -> `rpnvitals-btn-3` (Type: button, Required: 0)
* **rpnvitals_screen** -> `rpnvitals-screen` (Type: layout, Required: 0)
* **rpnvitals_content** -> `rpnvitals-content` (Type: layout, Required: 0)
* **rpnvitals_loading** -> `rpnvitals-loading` (Type: loading, Required: 0)
* **rpnvitals_title** -> `rpnvitals-title` (Type: header, Required: 0)
* **rpnvitals_btn_2** -> `rpnvitals-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `377` (Required: 1)
* Component ID: `911` (Required: 1)
* Component ID: `1445` (Required: 1)
* Component ID: `4884` (Required: 1)
* Component ID: `4885` (Required: 1)
* Component ID: `4886` (Required: 1)
* Component ID: `4887` (Required: 1)
* Component ID: `4888` (Required: 1)
* Component ID: `4889` (Required: 1)
* Component ID: `4890` (Required: 1)
* Component ID: `4891` (Required: 1)
* Component ID: `4892` (Required: 1)
* Component ID: `4893` (Required: 1)

## 7. API / Data Mapping
* API ID: `4740` (Required: 1)
* API ID: `4741` (Required: 1)
* API ID: `4742` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_vitals_runtime`
* **Test Name**: `RpnVitalsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rpn Vitals`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Rpn Vitals`)
4. **click_sidebar_link** (Selector: `None`, Value: `Rpn Vitals`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/vitals`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
