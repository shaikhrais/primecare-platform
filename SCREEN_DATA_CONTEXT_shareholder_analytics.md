# SCREEN DATA CONTEXT: shareholder_analytics

Below are the database records from `governance.db` used to configure and build the **Shareholder - ShareholderAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `180`
* **App ID**: `1`
* **Role ID**: `30`
* **Screen Code**: `shareholder_analytics`
* **Screen Name**: `ShareholderAnalyticsScreen`
* **Route Path**: `/executive/shareholder-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/shareholder_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `30`
* **Role Code**: `shareholder`
* **Role Name**: `Shareholder`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Shareholder personnel to oversee, audit, and coordinate operations related to shareholderanalyticsscreen.`
* **User Story**: `As a Shareholder, I want to access the ShareholderAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ShareholderAnalyticsScreen`
* **Acceptance Criteria**:
- The ShareholderAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shareholder access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `shareholder_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `shareholder_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `shareholder_analytics-content` (Type: layout, Required: 1)
* **shareholderanalytics_btn_3** -> `shareholderanalytics-btn-3` (Type: button, Required: 0)
* **shareholderanalytics_btn_1** -> `shareholderanalytics-btn-1` (Type: button, Required: 0)
* **shareholderanalytics_title** -> `shareholderanalytics-title` (Type: header, Required: 0)
* **shareholderanalytics_content** -> `shareholderanalytics-content` (Type: layout, Required: 0)
* **shareholderanalytics_screen** -> `shareholderanalytics-screen` (Type: layout, Required: 0)
* **shareholderanalytics_btn_2** -> `shareholderanalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `188` (Required: 1)
* Component ID: `722` (Required: 1)
* Component ID: `1256` (Required: 1)
* Component ID: `3179` (Required: 1)
* Component ID: `3180` (Required: 1)
* Component ID: `3181` (Required: 1)
* Component ID: `3182` (Required: 1)
* Component ID: `3183` (Required: 1)
* Component ID: `3184` (Required: 1)
* Component ID: `3185` (Required: 1)

## 7. API / Data Mapping
* API ID: `4469` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `shareholder_analytics_runtime`
* **Test Name**: `ShareholderAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ShareholderAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `shareholder`)
2. **visit** (Selector: `None`, Value: `/executive/shareholder-analytics`)
3. **should_be_visible** (Selector: `shareholder_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `shareholder_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `shareholder_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
