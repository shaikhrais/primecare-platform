# SCREEN DATA CONTEXT: infrastructure_analytics

Below are the database records from `governance.db` used to configure and build the **Infrastructure Auditor - InfrastructureAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `116`
* **App ID**: `1`
* **Role ID**: `17`
* **Screen Code**: `infrastructure_analytics`
* **Screen Name**: `InfrastructureAnalyticsScreen`
* **Route Path**: `/common/infrastructure-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/infrastructure_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `17`
* **Role Code**: `infrastructure`
* **Role Name**: `Infrastructure Auditor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Infrastructure Auditor personnel to oversee, audit, and coordinate operations related to infrastructureanalyticsscreen.`
* **User Story**: `As a Infrastructure Auditor, I want to access the InfrastructureAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `InfrastructureAnalyticsScreen`
* **Acceptance Criteria**:
- The InfrastructureAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Infrastructure Auditor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `infrastructure_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `infrastructure_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `infrastructure_analytics-content` (Type: layout, Required: 1)
* **infrastructureanalytics_loading** -> `infrastructureanalytics-loading` (Type: loading, Required: 0)
* **infrastructureanalytics_screen** -> `infrastructureanalytics-screen` (Type: layout, Required: 0)
* **infrastructureanalytics_btn_2** -> `infrastructureanalytics-btn-2` (Type: button, Required: 0)
* **infrastructureanalytics_btn_1** -> `infrastructureanalytics-btn-1` (Type: button, Required: 0)
* **infrastructureanalytics_btn_3** -> `infrastructureanalytics-btn-3` (Type: button, Required: 0)
* **infrastructureanalytics_title** -> `infrastructureanalytics-title` (Type: header, Required: 0)
* **infrastructureanalytics_content** -> `infrastructureanalytics-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `124` (Required: 1)
* Component ID: `658` (Required: 1)
* Component ID: `1192` (Required: 1)
* Component ID: `2588` (Required: 1)
* Component ID: `2589` (Required: 1)
* Component ID: `2590` (Required: 1)
* Component ID: `2591` (Required: 1)
* Component ID: `2592` (Required: 1)
* Component ID: `2593` (Required: 1)
* Component ID: `2594` (Required: 1)
* Component ID: `2595` (Required: 1)
* Component ID: `2596` (Required: 1)
* Component ID: `2597` (Required: 1)

## 7. API / Data Mapping
* API ID: `4393` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `infrastructure_analytics_runtime`
* **Test Name**: `InfrastructureAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `InfrastructureAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `infrastructure`)
2. **visit** (Selector: `None`, Value: `/common/infrastructure-analytics`)
3. **should_be_visible** (Selector: `infrastructure_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `infrastructure_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `infrastructure_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
