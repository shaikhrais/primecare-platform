# SCREEN DATA CONTEXT: physiotherapist_analytics

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `128`
* **App ID**: `1`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_analytics`
* **Screen Name**: `PhysiotherapistAnalyticsScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/physiotherapist_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistanalyticsscreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistAnalyticsScreen`
* **Acceptance Criteria**:
- The PhysiotherapistAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_analytics-content` (Type: layout, Required: 1)
* **physiotherapistanalytics_btn_1** -> `physiotherapistanalytics-btn-1` (Type: button, Required: 0)
* **physiotherapistanalytics_screen** -> `physiotherapistanalytics-screen` (Type: layout, Required: 0)
* **physiotherapistanalytics_btn_2** -> `physiotherapistanalytics-btn-2` (Type: button, Required: 0)
* **physiotherapistanalytics_content** -> `physiotherapistanalytics-content` (Type: layout, Required: 0)
* **physiotherapistanalytics_title** -> `physiotherapistanalytics-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `136` (Required: 1)
* Component ID: `670` (Required: 1)
* Component ID: `1204` (Required: 1)
* Component ID: `2690` (Required: 1)
* Component ID: `2691` (Required: 1)
* Component ID: `2692` (Required: 1)
* Component ID: `2693` (Required: 1)
* Component ID: `2694` (Required: 1)
* Component ID: `2695` (Required: 1)
* Component ID: `2696` (Required: 1)
* Component ID: `2697` (Required: 1)

## 7. API / Data Mapping
* API ID: `4411` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_analytics_runtime`
* **Test Name**: `PhysiotherapistAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PhysiotherapistAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/analytics`)
3. **should_be_visible** (Selector: `physiotherapist_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `physiotherapist_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `physiotherapist_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
