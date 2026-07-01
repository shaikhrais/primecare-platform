# SCREEN DATA CONTEXT: lead_analytics

Below are the database records from `governance.db` used to configure and build the **Head of Marketing - LeadAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `500`
* **App ID**: `11`
* **Role ID**: `38`
* **Screen Code**: `lead_analytics`
* **Screen Name**: `LeadAnalyticsScreen`
* **Route Path**: `/management/lead-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/lead_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `11`
* **App Code**: `ma`
* **App Name**: `Primecare Marketing`

## 3. Role Record
* **ID**: `38`
* **Role Code**: `marketing`
* **Role Name**: `Head of Marketing`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Marketing module to enable Head of Marketing personnel to oversee, audit, and coordinate operations related to leadanalyticsscreen.`
* **User Story**: `As a Head of Marketing, I want to access the LeadAnalyticsScreen within the Primecare Marketing application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `LeadAnalyticsScreen`
* **Acceptance Criteria**:
- The LeadAnalyticsScreen route loads successfully within the Primecare Marketing workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Marketing access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `lead_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `lead_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `lead_analytics-content` (Type: layout, Required: 1)
* **leadanalytics_loading** -> `leadanalytics-loading` (Type: loading, Required: 0)
* **leadanalytics_screen** -> `leadanalytics-screen` (Type: layout, Required: 0)
* **leadanalytics_btn_2** -> `leadanalytics-btn-2` (Type: button, Required: 0)
* **leadanalytics_title** -> `leadanalytics-title` (Type: header, Required: 0)
* **leadanalytics_content** -> `leadanalytics-content` (Type: layout, Required: 0)
* **leadanalytics_btn_3** -> `leadanalytics-btn-3` (Type: button, Required: 0)
* **leadanalytics_btn_1** -> `leadanalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `429` (Required: 1)
* Component ID: `963` (Required: 1)
* Component ID: `1497` (Required: 1)
* Component ID: `5381` (Required: 1)
* Component ID: `5382` (Required: 1)
* Component ID: `5383` (Required: 1)
* Component ID: `5384` (Required: 1)
* Component ID: `5385` (Required: 1)
* Component ID: `5386` (Required: 1)
* Component ID: `5387` (Required: 1)
* Component ID: `5388` (Required: 1)
* Component ID: `5389` (Required: 1)
* Component ID: `5390` (Required: 1)

## 7. API / Data Mapping
* API ID: `4817` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `lead_analytics_runtime`
* **Test Name**: `LeadAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Lead Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `marketing`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Lead Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Lead Analytics`)
5. **check_url** (Selector: `None`, Value: `/management/lead-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
