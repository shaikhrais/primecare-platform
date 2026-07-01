# SCREEN DATA CONTEXT: head_of_marketing_analytics

Below are the database records from `governance.db` used to configure and build the **Head of Marketing - HeadOfMarketingAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `204`
* **App ID**: `1`
* **Role ID**: `38`
* **Screen Code**: `head_of_marketing_analytics`
* **Screen Name**: `HeadOfMarketingAnalyticsScreen`
* **Route Path**: `/management/head-of-marketing-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/head_of_marketing_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `38`
* **Role Code**: `marketing`
* **Role Name**: `Head of Marketing`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Head of Marketing personnel to oversee, audit, and coordinate operations related to headofmarketinganalyticsscreen.`
* **User Story**: `As a Head of Marketing, I want to access the HeadOfMarketingAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HeadOfMarketingAnalyticsScreen`
* **Acceptance Criteria**:
- The HeadOfMarketingAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Marketing access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_marketing_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_marketing_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_marketing_analytics-content` (Type: layout, Required: 1)
* **headofmarketinganalytics_content** -> `headofmarketinganalytics-content` (Type: layout, Required: 0)
* **headofmarketinganalytics_screen** -> `headofmarketinganalytics-screen` (Type: layout, Required: 0)
* **headofmarketinganalytics_btn_2** -> `headofmarketinganalytics-btn-2` (Type: button, Required: 0)
* **headofmarketinganalytics_title** -> `headofmarketinganalytics-title` (Type: header, Required: 0)
* **headofmarketinganalytics_btn_1** -> `headofmarketinganalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `212` (Required: 1)
* Component ID: `746` (Required: 1)
* Component ID: `1280` (Required: 1)
* Component ID: `3393` (Required: 1)
* Component ID: `3394` (Required: 1)
* Component ID: `3395` (Required: 1)
* Component ID: `3396` (Required: 1)
* Component ID: `3397` (Required: 1)
* Component ID: `3398` (Required: 1)
* Component ID: `3399` (Required: 1)
* Component ID: `3400` (Required: 1)
* Component ID: `3401` (Required: 1)
* Component ID: `3402` (Required: 1)

## 7. API / Data Mapping
* API ID: `4493` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_marketing_analytics_runtime`
* **Test Name**: `HeadOfMarketingAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Head Of Marketing Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `marketing`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Head Of Marketing Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Head Of Marketing Analytics`)
5. **check_url** (Selector: `None`, Value: `/management/head-of-marketing-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
