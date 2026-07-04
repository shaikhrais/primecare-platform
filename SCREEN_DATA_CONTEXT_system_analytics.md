# SCREEN DATA CONTEXT: system_analytics

Below are the database records from `governance.db` used to configure and build the **System Verification Officer - SystemAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `144`
* **App ID**: `1`
* **Role ID**: `18`
* **Screen Code**: `system_analytics`
* **Screen Name**: `SystemAnalyticsScreen`
* **Route Path**: `/common/system-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/system_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `18`
* **Role Code**: `system_verification`
* **Role Name**: `System Verification Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable System Verification Officer personnel to oversee, audit, and coordinate operations related to systemanalyticsscreen.`
* **User Story**: `As a System Verification Officer, I want to access the SystemAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SystemAnalyticsScreen`
* **Acceptance Criteria**:
- The SystemAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only System Verification Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `system_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `system_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `system_analytics-content` (Type: layout, Required: 1)
* **systemanalytics_screen** -> `systemanalytics-screen` (Type: layout, Required: 0)
* **systemanalytics_btn_1** -> `systemanalytics-btn-1` (Type: button, Required: 0)
* **systemanalytics_content** -> `systemanalytics-content` (Type: layout, Required: 0)
* **systemanalytics_btn_2** -> `systemanalytics-btn-2` (Type: button, Required: 0)
* **systemanalytics_title** -> `systemanalytics-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `152` (Required: 1)
* Component ID: `686` (Required: 1)
* Component ID: `1220` (Required: 1)
* Component ID: `2834` (Required: 1)
* Component ID: `2835` (Required: 1)
* Component ID: `2836` (Required: 1)
* Component ID: `2837` (Required: 1)
* Component ID: `2838` (Required: 1)
* Component ID: `2839` (Required: 1)
* Component ID: `2840` (Required: 1)
* Component ID: `2841` (Required: 1)
* Component ID: `2842` (Required: 1)
* Component ID: `2843` (Required: 1)

## 7. API / Data Mapping
* API ID: `4427` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `system_analytics_runtime`
* **Test Name**: `SystemAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SystemAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `system_verification`)
2. **visit** (Selector: `None`, Value: `/common/system-analytics`)
3. **should_be_visible** (Selector: `system_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `system_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `system_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
