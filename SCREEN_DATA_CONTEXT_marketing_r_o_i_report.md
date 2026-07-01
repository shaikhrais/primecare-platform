# SCREEN DATA CONTEXT: marketing_r_o_i_report

Below are the database records from `governance.db` used to configure and build the **Guest - MarketingROIReportScreen** screen.

---

## 1. Screen Record
* **ID**: `940`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `marketing_r_o_i_report`
* **Screen Name**: `MarketingROIReportScreen`
* **Route Path**: `/generated/marketing-r-o-i-report`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/analytics/marketing_roi_report.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to marketing r o i report.`
* **User Story**: `As a Guest, I want to access the Marketing R O I Report within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Marketing R O I Report`
* **Acceptance Criteria**:
- The Marketing R O I Report route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `marketing_r_o_i_report-screen` (Type: layout, Required: 1)
* **page_title** -> `marketing_r_o_i_report-title` (Type: header, Required: 1)
* **primary_content** -> `marketing_r_o_i_report-content` (Type: layout, Required: 1)
* **marketing_roi_report_iconbutton_button_1** -> `marketing_roi_report_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8144` (Required: 1)
* Component ID: `8145` (Required: 1)
* Component ID: `8146` (Required: 1)

## 7. API / Data Mapping
* API ID: `5376` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `marketing_r_o_i_report_runtime`
* **Test Name**: `Marketing R O I Report Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Marketing R O I Report`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Marketing R O I Report`)
4. **click_sidebar_link** (Selector: `None`, Value: `Marketing R O I Report`)
5. **check_url** (Selector: `None`, Value: `/generated/marketing-r-o-i-report`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
