# SCREEN DATA CONTEXT: chronic_care_management_tracker

Below are the database records from `governance.db` used to configure and build the **Guest - ChronicCareManagementTrackerScreen** screen.

---

## 1. Screen Record
* **ID**: `1019`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `chronic_care_management_tracker`
* **Screen Name**: `ChronicCareManagementTrackerScreen`
* **Route Path**: `/generated/chronic-care-management-tracker`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/telehealth/chronic_care_management_tracker.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to chronic care management tracker.`
* **User Story**: `As a Guest, I want to access the Chronic Care Management Tracker within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Chronic Care Management Tracker`
* **Acceptance Criteria**:
- The Chronic Care Management Tracker route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chronic_care_management_tracker-screen` (Type: layout, Required: 1)
* **page_title** -> `chronic_care_management_tracker-title` (Type: header, Required: 1)
* **primary_content** -> `chronic_care_management_tracker-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8593` (Required: 1)
* Component ID: `8594` (Required: 1)
* Component ID: `8595` (Required: 1)
* Component ID: `8596` (Required: 1)
* Component ID: `8597` (Required: 1)
* Component ID: `8598` (Required: 1)
* Component ID: `8599` (Required: 1)
* Component ID: `8600` (Required: 1)

## 7. API / Data Mapping
* API ID: `5485` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chronic_care_management_tracker_runtime`
* **Test Name**: `Chronic Care Management Tracker Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Chronic Care Management Tracker`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Chronic Care Management Tracker`)
4. **click_sidebar_link** (Selector: `None`, Value: `Chronic Care Management Tracker`)
5. **check_url** (Selector: `None`, Value: `/generated/chronic-care-management-tracker`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
