# SCREEN DATA CONTEXT: qa_analytics

Below are the database records from `governance.db` used to configure and build the **QA Specialist - QaAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `134`
* **App ID**: `1`
* **Role ID**: `63`
* **Screen Code**: `qa_analytics`
* **Screen Name**: `QaAnalyticsScreen`
* **Route Path**: `/common/qa-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/qa_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `63`
* **Role Code**: `qa_specialist`
* **Role Name**: `QA Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable QA Specialist personnel to oversee, audit, and coordinate operations related to qaanalyticsscreen.`
* **User Story**: `As a QA Specialist, I want to access the QaAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `QaAnalyticsScreen`
* **Acceptance Criteria**:
- The QaAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only QA Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `qa_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `qa_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `qa_analytics-content` (Type: layout, Required: 1)
* **qaanalytics_screen** -> `qaanalytics-screen` (Type: layout, Required: 0)
* **qaanalytics_btn_2** -> `qaanalytics-btn-2` (Type: button, Required: 0)
* **qaanalytics_content** -> `qaanalytics-content` (Type: layout, Required: 0)
* **qaanalytics_btn_1** -> `qaanalytics-btn-1` (Type: button, Required: 0)
* **qaanalytics_title** -> `qaanalytics-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `142` (Required: 1)
* Component ID: `676` (Required: 1)
* Component ID: `1210` (Required: 1)
* Component ID: `2745` (Required: 1)
* Component ID: `2746` (Required: 1)
* Component ID: `2747` (Required: 1)
* Component ID: `2748` (Required: 1)
* Component ID: `2749` (Required: 1)
* Component ID: `2750` (Required: 1)
* Component ID: `2751` (Required: 1)
* Component ID: `2752` (Required: 1)
* Component ID: `2753` (Required: 1)
* Component ID: `2754` (Required: 1)

## 7. API / Data Mapping
* API ID: `4417` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `qa_analytics_runtime`
* **Test Name**: `QaAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `QaAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **visit** (Selector: `None`, Value: `/common/qa-analytics`)
3. **should_be_visible** (Selector: `qa_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `qa_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `qa_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
