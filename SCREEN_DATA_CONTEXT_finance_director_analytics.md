# SCREEN DATA CONTEXT: finance_director_analytics

Below are the database records from `governance.db` used to configure and build the **Finance Director - FinanceDirectorAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `168`
* **App ID**: `1`
* **Role ID**: `26`
* **Screen Code**: `finance_director_analytics`
* **Screen Name**: `FinanceDirectorAnalyticsScreen`
* **Route Path**: `/executive/finance-director-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/finance_director_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `26`
* **Role Code**: `finance_director`
* **Role Name**: `Finance Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Finance Director personnel to oversee, audit, and coordinate operations related to financedirectoranalyticsscreen.`
* **User Story**: `As a Finance Director, I want to access the FinanceDirectorAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FinanceDirectorAnalyticsScreen`
* **Acceptance Criteria**:
- The FinanceDirectorAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Finance Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `finance_director_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `finance_director_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `finance_director_analytics-content` (Type: layout, Required: 1)
* **financedirectoranalytics_btn_2** -> `financedirectoranalytics-btn-2` (Type: button, Required: 0)
* **financedirectoranalytics_content** -> `financedirectoranalytics-content` (Type: layout, Required: 0)
* **financedirectoranalytics_btn_1** -> `financedirectoranalytics-btn-1` (Type: button, Required: 0)
* **financedirectoranalytics_title** -> `financedirectoranalytics-title` (Type: header, Required: 0)
* **financedirectoranalytics_btn_3** -> `financedirectoranalytics-btn-3` (Type: button, Required: 0)
* **financedirectoranalytics_screen** -> `financedirectoranalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `176` (Required: 1)
* Component ID: `710` (Required: 1)
* Component ID: `1244` (Required: 1)
* Component ID: `3060` (Required: 1)
* Component ID: `3061` (Required: 1)
* Component ID: `3062` (Required: 1)
* Component ID: `3063` (Required: 1)
* Component ID: `3064` (Required: 1)
* Component ID: `3065` (Required: 1)
* Component ID: `3066` (Required: 1)
* Component ID: `3067` (Required: 1)
* Component ID: `3068` (Required: 1)
* Component ID: `3069` (Required: 1)

## 7. API / Data Mapping
* API ID: `4457` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `finance_director_analytics_runtime`
* **Test Name**: `FinanceDirectorAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FinanceDirectorAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `finance_director`)
2. **visit** (Selector: `None`, Value: `/executive/finance-director-analytics`)
3. **should_be_visible** (Selector: `finance_director_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `finance_director_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `finance_director_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
