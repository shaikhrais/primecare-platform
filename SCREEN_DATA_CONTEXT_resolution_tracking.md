# SCREEN DATA CONTEXT: resolution_tracking

Below are the database records from `governance.db` used to configure and build the **Customer Support - ResolutionTrackingScreen** screen.

---

## 1. Screen Record
* **ID**: `560`
* **App ID**: `5`
* **Role ID**: `61`
* **Screen Code**: `resolution_tracking`
* **Screen Name**: `ResolutionTrackingScreen`
* **Route Path**: `/staff/resolution-tracking`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/resolution_tracking_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `61`
* **Role Code**: `customer_support`
* **Role Name**: `Customer Support`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Customer Support personnel to oversee, audit, and coordinate operations related to resolutiontrackingscreen.`
* **User Story**: `As a Customer Support, I want to access the ResolutionTrackingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ResolutionTrackingScreen`
* **Acceptance Criteria**:
- The ResolutionTrackingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Customer Support access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `resolution_tracking-screen` (Type: layout, Required: 1)
* **page_title** -> `resolution_tracking-title` (Type: header, Required: 1)
* **primary_content** -> `resolution_tracking-content` (Type: layout, Required: 1)
* **resolutiontracking_title** -> `resolutiontracking-title` (Type: header, Required: 0)
* **resolutiontracking_btn_3** -> `resolutiontracking-btn-3` (Type: button, Required: 0)
* **resolutiontracking_screen** -> `resolutiontracking-screen` (Type: layout, Required: 0)
* **resolutiontracking_btn_2** -> `resolutiontracking-btn-2` (Type: button, Required: 0)
* **resolutiontracking_btn_1** -> `resolutiontracking-btn-1` (Type: button, Required: 0)
* **resolutiontracking_btn_5** -> `resolutiontracking-btn-5` (Type: button, Required: 0)
* **resolutiontracking_btn_4** -> `resolutiontracking-btn-4` (Type: button, Required: 0)
* **resolutiontracking_content** -> `resolutiontracking-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `484` (Required: 1)
* Component ID: `1018` (Required: 1)
* Component ID: `1552` (Required: 1)
* Component ID: `5900` (Required: 1)
* Component ID: `5901` (Required: 1)
* Component ID: `5902` (Required: 1)
* Component ID: `5903` (Required: 1)
* Component ID: `5904` (Required: 1)
* Component ID: `5905` (Required: 1)
* Component ID: `5906` (Required: 1)
* Component ID: `5907` (Required: 1)

## 7. API / Data Mapping
* API ID: `4907` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `resolution_tracking_runtime`
* **Test Name**: `ResolutionTrackingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ResolutionTrackingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **visit** (Selector: `None`, Value: `/staff/resolution-tracking`)
3. **should_be_visible** (Selector: `resolution_tracking-screen`, Value: `None`)
4. **should_be_visible** (Selector: `resolution_tracking-title`, Value: `None`)
5. **should_be_visible** (Selector: `resolution_tracking-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
