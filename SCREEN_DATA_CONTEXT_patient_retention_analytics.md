# SCREEN DATA CONTEXT: patient_retention_analytics

Below are the database records from `governance.db` used to configure and build the **Guest - PatientRetentionAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `942`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `patient_retention_analytics`
* **Screen Name**: `PatientRetentionAnalyticsScreen`
* **Route Path**: `/generated/patient-retention-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/analytics/patient_retention_analytics.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to patient retention analytics.`
* **User Story**: `As a Guest, I want to access the Patient Retention Analytics within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Patient Retention Analytics`
* **Acceptance Criteria**:
- The Patient Retention Analytics route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_retention_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_retention_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `patient_retention_analytics-content` (Type: layout, Required: 1)
* **patient_retention_analytics_iconbutton_button_1** -> `patient_retention_analytics_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8150` (Required: 1)
* Component ID: `8151` (Required: 1)
* Component ID: `8152` (Required: 1)
* Component ID: `8153` (Required: 1)

## 7. API / Data Mapping
* API ID: `5378` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_retention_analytics_runtime`
* **Test Name**: `Patient Retention Analytics Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient Retention Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Patient Retention Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Patient Retention Analytics`)
5. **check_url** (Selector: `None`, Value: `/generated/patient-retention-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
