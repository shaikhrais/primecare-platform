# SCREEN DATA CONTEXT: clinical_analytics

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `79`
* **App ID**: `1`
* **Role ID**: `6`
* **Screen Code**: `clinical_analytics`
* **Screen Name**: `ClinicalAnalyticsScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `6`
* **Role Code**: `clinical_director`
* **Role Name**: `Clinical Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicalanalyticsscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalAnalyticsScreen`
* **Acceptance Criteria**:
- The ClinicalAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_analytics-content` (Type: layout, Required: 1)
* **clinicalanalytics_content** -> `clinicalanalytics-content` (Type: layout, Required: 0)
* **clinicalanalytics_title** -> `clinicalanalytics-title` (Type: header, Required: 0)
* **clinicalanalytics_btn_1** -> `clinicalanalytics-btn-1` (Type: button, Required: 0)
* **clinicalanalytics_btn_2** -> `clinicalanalytics-btn-2` (Type: button, Required: 0)
* **clinicalanalytics_screen** -> `clinicalanalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `87` (Required: 1)
* Component ID: `621` (Required: 1)
* Component ID: `1155` (Required: 1)
* Component ID: `2285` (Required: 1)
* Component ID: `2286` (Required: 1)
* Component ID: `2287` (Required: 1)
* Component ID: `2288` (Required: 1)
* Component ID: `2289` (Required: 1)
* Component ID: `2290` (Required: 1)
* Component ID: `2291` (Required: 1)
* Component ID: `2292` (Required: 1)
* Component ID: `2293` (Required: 1)
* Component ID: `2294` (Required: 1)

## 7. API / Data Mapping
* API ID: `4350` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_analytics_runtime`
* **Test Name**: `ClinicalAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinical Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinical Analytics`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
