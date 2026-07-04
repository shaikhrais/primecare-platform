# SCREEN DATA CONTEXT: portal_analytics

Below are the database records from `governance.db` used to configure and build the **Portal User - PortalAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `131`
* **App ID**: `1`
* **Role ID**: `14`
* **Screen Code**: `portal_analytics`
* **Screen Name**: `PortalAnalyticsScreen`
* **Route Path**: `/common/portal-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/portal_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `14`
* **Role Code**: `portal`
* **Role Name**: `Portal User`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Portal User personnel to oversee, audit, and coordinate operations related to portalanalyticsscreen.`
* **User Story**: `As a Portal User, I want to access the PortalAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PortalAnalyticsScreen`
* **Acceptance Criteria**:
- The PortalAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Portal User access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `portal_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `portal_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `portal_analytics-content` (Type: layout, Required: 1)
* **portalanalytics_content** -> `portalanalytics-content` (Type: layout, Required: 0)
* **portalanalytics_screen** -> `portalanalytics-screen` (Type: layout, Required: 0)
* **portalanalytics_title** -> `portalanalytics-title` (Type: header, Required: 0)
* **portalanalytics_btn_2** -> `portalanalytics-btn-2` (Type: button, Required: 0)
* **portalanalytics_btn_3** -> `portalanalytics-btn-3` (Type: button, Required: 0)
* **portalanalytics_btn_1** -> `portalanalytics-btn-1` (Type: button, Required: 0)
* **portalanalytics_loading** -> `portalanalytics-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `139` (Required: 1)
* Component ID: `673` (Required: 1)
* Component ID: `1207` (Required: 1)
* Component ID: `2713` (Required: 1)
* Component ID: `2714` (Required: 1)
* Component ID: `2715` (Required: 1)
* Component ID: `2716` (Required: 1)
* Component ID: `2717` (Required: 1)
* Component ID: `2718` (Required: 1)
* Component ID: `2719` (Required: 1)
* Component ID: `2720` (Required: 1)

## 7. API / Data Mapping
* API ID: `4414` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `portal_analytics_runtime`
* **Test Name**: `PortalAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PortalAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `portal`)
2. **visit** (Selector: `None`, Value: `/common/portal-analytics`)
3. **should_be_visible** (Selector: `portal_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `portal_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `portal_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
