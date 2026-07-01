# SCREEN DATA CONTEXT: rpn_analytics

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `244`
* **App ID**: `1`
* **Role ID**: `55`
* **Screen Code**: `rpn_analytics`
* **Screen Name**: `RpnAnalyticsScreen`
* **Route Path**: `/offices/clinical/roles/rpn/rpn-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_analytics_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpnanalyticsscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnAnalyticsScreen`
* **Acceptance Criteria**:
- The RpnAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_analytics-content` (Type: layout, Required: 1)
* **rpn_analytics_screen_textfield_input_1** -> `rpn_analytics_screen_textfield_input_1` (Type: field, Required: 0)
* **rpnanalytics_btn_1** -> `rpnanalytics-btn-1` (Type: button, Required: 0)
* **rpnanalytics_btn_4** -> `rpnanalytics-btn-4` (Type: button, Required: 0)
* **rpnanalytics_screen** -> `rpnanalytics-screen` (Type: layout, Required: 0)
* **rpnanalytics_btn_2** -> `rpnanalytics-btn-2` (Type: button, Required: 0)
* **rpnanalytics_title** -> `rpnanalytics-title` (Type: header, Required: 0)
* **rpnanalytics_content** -> `rpnanalytics-content` (Type: layout, Required: 0)
* **rpnanalytics_btn_3** -> `rpnanalytics-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `252` (Required: 1)
* Component ID: `786` (Required: 1)
* Component ID: `1320` (Required: 1)
* Component ID: `3760` (Required: 1)
* Component ID: `3761` (Required: 1)
* Component ID: `3762` (Required: 1)
* Component ID: `3763` (Required: 1)
* Component ID: `3764` (Required: 1)
* Component ID: `3765` (Required: 1)
* Component ID: `3766` (Required: 1)
* Component ID: `3767` (Required: 1)
* Component ID: `3768` (Required: 1)
* Component ID: `3769` (Required: 1)

## 7. API / Data Mapping
* API ID: `4551` (Required: 1)
* API ID: `4552` (Required: 1)
* API ID: `4553` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_analytics_runtime`
* **Test Name**: `RpnAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rpn Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Rpn Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Rpn Analytics`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/rpn-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
