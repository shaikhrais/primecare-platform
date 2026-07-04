# SCREEN DATA CONTEXT: intake_analytics

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - IntakeAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `119`
* **App ID**: `1`
* **Role ID**: `7`
* **Screen Code**: `intake_analytics`
* **Screen Name**: `IntakeAnalyticsScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/intake_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `7`
* **Role Code**: `intake`
* **Role Name**: `Intake Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to intakeanalyticsscreen.`
* **User Story**: `As a Intake Coordinator, I want to access the IntakeAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeAnalyticsScreen`
* **Acceptance Criteria**:
- The IntakeAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `intake_analytics-content` (Type: layout, Required: 1)
* **intakeanalytics_content** -> `intakeanalytics-content` (Type: layout, Required: 0)
* **intakeanalytics_btn_2** -> `intakeanalytics-btn-2` (Type: button, Required: 0)
* **intakeanalytics_title** -> `intakeanalytics-title` (Type: header, Required: 0)
* **intakeanalytics_btn_1** -> `intakeanalytics-btn-1` (Type: button, Required: 0)
* **intakeanalytics_screen** -> `intakeanalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `127` (Required: 1)
* Component ID: `661` (Required: 1)
* Component ID: `1195` (Required: 1)
* Component ID: `2618` (Required: 1)
* Component ID: `2619` (Required: 1)
* Component ID: `2620` (Required: 1)
* Component ID: `2621` (Required: 1)
* Component ID: `2622` (Required: 1)
* Component ID: `2623` (Required: 1)
* Component ID: `2624` (Required: 1)

## 7. API / Data Mapping
* API ID: `4396` (Required: 1)
* API ID: `4397` (Required: 1)
* API ID: `4398` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_analytics_runtime`
* **Test Name**: `IntakeAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `IntakeAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/analytics`)
3. **should_be_visible** (Selector: `intake_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `intake_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `intake_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
