# SCREEN DATA CONTEXT: hr_manager_analytics

Below are the database records from `governance.db` used to configure and build the **HR Director - HrManagerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `257`
* **App ID**: `1`
* **Role ID**: `27`
* **Screen Code**: `hr_manager_analytics`
* **Screen Name**: `HrManagerAnalyticsScreen`
* **Route Path**: `/staff/hr-manager-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/hr_manager_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrmanageranalyticsscreen.`
* **User Story**: `As a HR Director, I want to access the HrManagerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrManagerAnalyticsScreen`
* **Acceptance Criteria**:
- The HrManagerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_manager_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_manager_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `hr_manager_analytics-content` (Type: layout, Required: 1)
* **hrmanageranalytics_title** -> `hrmanageranalytics-title` (Type: header, Required: 0)
* **hrmanageranalytics_btn_3** -> `hrmanageranalytics-btn-3` (Type: button, Required: 0)
* **hrmanageranalytics_screen** -> `hrmanageranalytics-screen` (Type: layout, Required: 0)
* **hrmanageranalytics_btn_1** -> `hrmanageranalytics-btn-1` (Type: button, Required: 0)
* **hrmanageranalytics_btn_2** -> `hrmanageranalytics-btn-2` (Type: button, Required: 0)
* **hrmanageranalytics_content** -> `hrmanageranalytics-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `265` (Required: 1)
* Component ID: `799` (Required: 1)
* Component ID: `1333` (Required: 1)
* Component ID: `3890` (Required: 1)
* Component ID: `3891` (Required: 1)
* Component ID: `3892` (Required: 1)
* Component ID: `3893` (Required: 1)
* Component ID: `3894` (Required: 1)
* Component ID: `3895` (Required: 1)

## 7. API / Data Mapping
* API ID: `4572` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_manager_analytics_runtime`
* **Test Name**: `HrManagerAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrManagerAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **visit** (Selector: `None`, Value: `/staff/hr-manager-analytics`)
3. **should_be_visible** (Selector: `hr_manager_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_manager_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_manager_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
