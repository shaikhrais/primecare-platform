# SCREEN DATA CONTEXT: clinical_outcomes_report

Below are the database records from `governance.db` used to configure and build the **Guest - ClinicalOutcomesReportScreen** screen.

---

## 1. Screen Record
* **ID**: `938`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `clinical_outcomes_report`
* **Screen Name**: `ClinicalOutcomesReportScreen`
* **Route Path**: `/generated/clinical-outcomes-report`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/analytics/clinical_outcomes_report.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to clinical outcomes report.`
* **User Story**: `As a Guest, I want to access the Clinical Outcomes Report within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Clinical Outcomes Report`
* **Acceptance Criteria**:
- The Clinical Outcomes Report route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_outcomes_report-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_outcomes_report-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_outcomes_report-content` (Type: layout, Required: 1)
* **clinical_outcomes_report_iconbutton_button_1** -> `clinical_outcomes_report_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8137` (Required: 1)
* Component ID: `8138` (Required: 1)
* Component ID: `8139` (Required: 1)

## 7. API / Data Mapping
* API ID: `5374` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_outcomes_report_runtime`
* **Test Name**: `Clinical Outcomes Report Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Outcomes Report`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinical Outcomes Report`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinical Outcomes Report`)
5. **check_url** (Selector: `None`, Value: `/generated/clinical-outcomes-report`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
