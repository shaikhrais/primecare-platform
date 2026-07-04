# SCREEN DATA CONTEXT: office_analytics

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - OfficeAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `122`
* **App ID**: `1`
* **Role ID**: `59`
* **Screen Code**: `office_analytics`
* **Screen Name**: `OfficeAnalyticsScreen`
* **Route Path**: `/common/office-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/office_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to officeanalyticsscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the OfficeAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OfficeAnalyticsScreen`
* **Acceptance Criteria**:
- The OfficeAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `office_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `office_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `office_analytics-content` (Type: layout, Required: 1)
* **officeanalytics_btn_2** -> `officeanalytics-btn-2` (Type: button, Required: 0)
* **officeanalytics_content** -> `officeanalytics-content` (Type: layout, Required: 0)
* **officeanalytics_screen** -> `officeanalytics-screen` (Type: layout, Required: 0)
* **officeanalytics_title** -> `officeanalytics-title` (Type: header, Required: 0)
* **officeanalytics_btn_1** -> `officeanalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `130` (Required: 1)
* Component ID: `664` (Required: 1)
* Component ID: `1198` (Required: 1)
* Component ID: `2643` (Required: 1)
* Component ID: `2644` (Required: 1)
* Component ID: `2645` (Required: 1)
* Component ID: `2646` (Required: 1)
* Component ID: `2647` (Required: 1)
* Component ID: `2648` (Required: 1)
* Component ID: `2649` (Required: 1)
* Component ID: `2650` (Required: 1)
* Component ID: `2651` (Required: 1)
* Component ID: `2652` (Required: 1)

## 7. API / Data Mapping
* API ID: `4405` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `office_analytics_runtime`
* **Test Name**: `OfficeAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OfficeAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/common/office-analytics`)
3. **should_be_visible** (Selector: `office_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `office_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `office_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
