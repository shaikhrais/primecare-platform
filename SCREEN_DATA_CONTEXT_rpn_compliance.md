# SCREEN DATA CONTEXT: rpn_compliance

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `245`
* **App ID**: `1`
* **Role ID**: `55`
* **Screen Code**: `rpn_compliance`
* **Screen Name**: `RpnComplianceScreen`
* **Route Path**: `/offices/clinical/roles/rpn/rpn-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `55`
* **Role Code**: `rpn`
* **Role Name**: `Registered Practical Nurse (RPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpncompliancescreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnComplianceScreen`
* **Acceptance Criteria**:
- The RpnComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_compliance-content` (Type: layout, Required: 1)
* **rpncompliance_btn_3** -> `rpncompliance-btn-3` (Type: button, Required: 0)
* **rpncompliance_title** -> `rpncompliance-title` (Type: header, Required: 0)
* **rpncompliance_loading** -> `rpncompliance-loading` (Type: loading, Required: 0)
* **rpncompliance_btn_2** -> `rpncompliance-btn-2` (Type: button, Required: 0)
* **rpncompliance_btn_1** -> `rpncompliance-btn-1` (Type: button, Required: 0)
* **rpncompliance_screen** -> `rpncompliance-screen` (Type: layout, Required: 0)
* **rpncompliance_content** -> `rpncompliance-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `253` (Required: 1)
* Component ID: `787` (Required: 1)
* Component ID: `1321` (Required: 1)
* Component ID: `3770` (Required: 1)
* Component ID: `3771` (Required: 1)
* Component ID: `3772` (Required: 1)
* Component ID: `3773` (Required: 1)
* Component ID: `3774` (Required: 1)
* Component ID: `3775` (Required: 1)
* Component ID: `3776` (Required: 1)
* Component ID: `3777` (Required: 1)
* Component ID: `3778` (Required: 1)
* Component ID: `3779` (Required: 1)

## 7. API / Data Mapping
* API ID: `4554` (Required: 1)
* API ID: `4555` (Required: 1)
* API ID: `4556` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_compliance_runtime`
* **Test Name**: `RpnComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rpn Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Rpn Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Rpn Compliance`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/rpn-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
