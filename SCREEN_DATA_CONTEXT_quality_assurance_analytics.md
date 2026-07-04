# SCREEN DATA CONTEXT: quality_assurance_analytics

Below are the database records from `governance.db` used to configure and build the **QA Specialist - QualityAssuranceAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `263`
* **App ID**: `1`
* **Role ID**: `63`
* **Screen Code**: `quality_assurance_analytics`
* **Screen Name**: `QualityAssuranceAnalyticsScreen`
* **Route Path**: `/staff/quality-assurance-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/quality_assurance_analytics_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable QA Specialist personnel to oversee, audit, and coordinate operations related to qualityassuranceanalyticsscreen.`
* **User Story**: `As a QA Specialist, I want to access the QualityAssuranceAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `QualityAssuranceAnalyticsScreen`
* **Acceptance Criteria**:
- The QualityAssuranceAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only QA Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `quality_assurance_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `quality_assurance_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `quality_assurance_analytics-content` (Type: layout, Required: 1)
* **qualityassuranceanalytics_screen** -> `qualityassuranceanalytics-screen` (Type: layout, Required: 0)
* **qualityassuranceanalytics_btn_1** -> `qualityassuranceanalytics-btn-1` (Type: button, Required: 0)
* **qualityassuranceanalytics_title** -> `qualityassuranceanalytics-title` (Type: header, Required: 0)
* **qualityassuranceanalytics_content** -> `qualityassuranceanalytics-content` (Type: layout, Required: 0)
* **qualityassuranceanalytics_btn_3** -> `qualityassuranceanalytics-btn-3` (Type: button, Required: 0)
* **qualityassuranceanalytics_btn_2** -> `qualityassuranceanalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `271` (Required: 1)
* Component ID: `805` (Required: 1)
* Component ID: `1339` (Required: 1)
* Component ID: `3941` (Required: 1)
* Component ID: `3942` (Required: 1)
* Component ID: `3943` (Required: 1)
* Component ID: `3944` (Required: 1)
* Component ID: `3945` (Required: 1)
* Component ID: `3946` (Required: 1)
* Component ID: `3947` (Required: 1)
* Component ID: `3948` (Required: 1)
* Component ID: `3949` (Required: 1)
* Component ID: `3950` (Required: 1)

## 7. API / Data Mapping
* API ID: `4584` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `quality_assurance_analytics_runtime`
* **Test Name**: `QualityAssuranceAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `QualityAssuranceAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **visit** (Selector: `None`, Value: `/staff/quality-assurance-analytics`)
3. **should_be_visible** (Selector: `quality_assurance_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `quality_assurance_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `quality_assurance_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
