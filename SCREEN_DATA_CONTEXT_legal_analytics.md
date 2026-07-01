# SCREEN DATA CONTEXT: legal_analytics

Below are the database records from `governance.db` used to configure and build the **Legal Counsel - LegalAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `174`
* **App ID**: `1`
* **Role ID**: `28`
* **Screen Code**: `legal_analytics`
* **Screen Name**: `LegalAnalyticsScreen`
* **Route Path**: `/executive/legal-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/legal_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `28`
* **Role Code**: `legal`
* **Role Name**: `Legal Counsel`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Legal Counsel personnel to oversee, audit, and coordinate operations related to legalanalyticsscreen.`
* **User Story**: `As a Legal Counsel, I want to access the LegalAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `LegalAnalyticsScreen`
* **Acceptance Criteria**:
- The LegalAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Legal Counsel access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `legal_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `legal_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `legal_analytics-content` (Type: layout, Required: 1)
* **legalanalytics_loading** -> `legalanalytics-loading` (Type: loading, Required: 0)
* **legalanalytics_btn_2** -> `legalanalytics-btn-2` (Type: button, Required: 0)
* **legalanalytics_screen** -> `legalanalytics-screen` (Type: layout, Required: 0)
* **legalanalytics_content** -> `legalanalytics-content` (Type: layout, Required: 0)
* **legalanalytics_btn_1** -> `legalanalytics-btn-1` (Type: button, Required: 0)
* **legalanalytics_title** -> `legalanalytics-title` (Type: header, Required: 0)
* **legalanalytics_btn_3** -> `legalanalytics-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `182` (Required: 1)
* Component ID: `716` (Required: 1)
* Component ID: `1250` (Required: 1)
* Component ID: `3119` (Required: 1)
* Component ID: `3120` (Required: 1)
* Component ID: `3121` (Required: 1)
* Component ID: `3122` (Required: 1)
* Component ID: `3123` (Required: 1)
* Component ID: `3124` (Required: 1)
* Component ID: `3125` (Required: 1)
* Component ID: `3126` (Required: 1)
* Component ID: `3127` (Required: 1)
* Component ID: `3128` (Required: 1)

## 7. API / Data Mapping
* API ID: `4463` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `legal_analytics_runtime`
* **Test Name**: `LegalAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Legal Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `legal`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Legal Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Legal Analytics`)
5. **check_url** (Selector: `None`, Value: `/executive/legal-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
