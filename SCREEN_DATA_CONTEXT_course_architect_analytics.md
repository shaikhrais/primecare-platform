# SCREEN DATA CONTEXT: course_architect_analytics

Below are the database records from `governance.db` used to configure and build the **Training Director - CourseArchitectAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `98`
* **App ID**: `1`
* **Role ID**: `31`
* **Screen Code**: `course_architect_analytics`
* **Screen Name**: `CourseArchitectAnalyticsScreen`
* **Route Path**: `/common/course-architect-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/course_architect_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `31`
* **Role Code**: `training_director`
* **Role Name**: `Training Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Training Director personnel to oversee, audit, and coordinate operations related to coursearchitectanalyticsscreen.`
* **User Story**: `As a Training Director, I want to access the CourseArchitectAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CourseArchitectAnalyticsScreen`
* **Acceptance Criteria**:
- The CourseArchitectAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `course_architect_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `course_architect_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `course_architect_analytics-content` (Type: layout, Required: 1)
* **coursearchitectanalytics_content** -> `coursearchitectanalytics-content` (Type: layout, Required: 0)
* **coursearchitectanalytics_btn_1** -> `coursearchitectanalytics-btn-1` (Type: button, Required: 0)
* **coursearchitectanalytics_title** -> `coursearchitectanalytics-title` (Type: header, Required: 0)
* **coursearchitectanalytics_screen** -> `coursearchitectanalytics-screen` (Type: layout, Required: 0)
* **coursearchitectanalytics_btn_2** -> `coursearchitectanalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `106` (Required: 1)
* Component ID: `640` (Required: 1)
* Component ID: `1174` (Required: 1)
* Component ID: `2455` (Required: 1)
* Component ID: `2456` (Required: 1)
* Component ID: `2457` (Required: 1)
* Component ID: `2458` (Required: 1)
* Component ID: `2459` (Required: 1)
* Component ID: `2460` (Required: 1)
* Component ID: `2461` (Required: 1)
* Component ID: `2462` (Required: 1)
* Component ID: `2463` (Required: 1)
* Component ID: `2464` (Required: 1)

## 7. API / Data Mapping
* API ID: `4375` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `course_architect_analytics_runtime`
* **Test Name**: `CourseArchitectAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Course Architect Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Course Architect Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Course Architect Analytics`)
5. **check_url** (Selector: `None`, Value: `/common/course-architect-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
