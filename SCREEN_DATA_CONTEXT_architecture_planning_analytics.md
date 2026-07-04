# SCREEN DATA CONTEXT: architecture_planning_analytics

Below are the database records from `governance.db` used to configure and build the **Infrastructure Auditor - ArchitecturePlanningAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `86`
* **App ID**: `1`
* **Role ID**: `17`
* **Screen Code**: `architecture_planning_analytics`
* **Screen Name**: `ArchitecturePlanningAnalyticsScreen`
* **Route Path**: `/common/architecture-planning-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/architecture_planning_analytics_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Infrastructure Auditor personnel to oversee, audit, and coordinate operations related to architectureplanninganalyticsscreen.`
* **User Story**: `As a Infrastructure Auditor, I want to access the ArchitecturePlanningAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ArchitecturePlanningAnalyticsScreen`
* **Acceptance Criteria**:
- The ArchitecturePlanningAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Infrastructure Auditor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `architecture_planning_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `architecture_planning_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `architecture_planning_analytics-content` (Type: layout, Required: 1)
* **architectureplanninganalytics_btn_2** -> `architectureplanninganalytics-btn-2` (Type: button, Required: 0)
* **architectureplanninganalytics_content** -> `architectureplanninganalytics-content` (Type: layout, Required: 0)
* **architectureplanninganalytics_btn_1** -> `architectureplanninganalytics-btn-1` (Type: button, Required: 0)
* **architectureplanninganalytics_screen** -> `architectureplanninganalytics-screen` (Type: layout, Required: 0)
* **architectureplanninganalytics_title** -> `architectureplanninganalytics-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `94` (Required: 1)
* Component ID: `628` (Required: 1)
* Component ID: `1162` (Required: 1)
* Component ID: `2344` (Required: 1)
* Component ID: `2345` (Required: 1)
* Component ID: `2346` (Required: 1)
* Component ID: `2347` (Required: 1)
* Component ID: `2348` (Required: 1)
* Component ID: `2349` (Required: 1)
* Component ID: `2350` (Required: 1)
* Component ID: `2351` (Required: 1)
* Component ID: `2352` (Required: 1)
* Component ID: `2353` (Required: 1)

## 7. API / Data Mapping
* API ID: `4363` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `architecture_planning_analytics_runtime`
* **Test Name**: `ArchitecturePlanningAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ArchitecturePlanningAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `infrastructure`)
2. **visit** (Selector: `None`, Value: `/common/architecture-planning-analytics`)
3. **should_be_visible** (Selector: `architecture_planning_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `architecture_planning_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `architecture_planning_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
