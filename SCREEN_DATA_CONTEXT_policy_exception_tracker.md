# SCREEN DATA CONTEXT: policy_exception_tracker

Below are the database records from `governance.db` used to configure and build the **Guest - PolicyExceptionTrackerScreen** screen.

---

## 1. Screen Record
* **ID**: `919`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `policy_exception_tracker`
* **Screen Name**: `PolicyExceptionTrackerScreen`
* **Route Path**: `/generated/policy-exception-tracker`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/policy_exception_tracker.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to policy exception tracker.`
* **User Story**: `As a Guest, I want to access the Policy Exception Tracker within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Policy Exception Tracker`
* **Acceptance Criteria**:
- The Policy Exception Tracker route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `policy_exception_tracker-screen` (Type: layout, Required: 1)
* **page_title** -> `policy_exception_tracker-title` (Type: header, Required: 1)
* **primary_content** -> `policy_exception_tracker-content` (Type: layout, Required: 1)
* **policy_exception_tracker_outlinedbutton_button_1** -> `policy_exception_tracker_outlinedbutton_button_1` (Type: button, Required: 0)
* **policy_exception_tracker_iconbutton_button_1** -> `policy_exception_tracker_iconbutton_button_1` (Type: button, Required: 0)
* **policy_exception_tracker_elevatedbutton_button_1** -> `policy_exception_tracker_elevatedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8042` (Required: 1)
* Component ID: `8043` (Required: 1)
* Component ID: `8044` (Required: 1)
* Component ID: `8045` (Required: 1)
* Component ID: `8046` (Required: 1)

## 7. API / Data Mapping
* API ID: `5341` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `policy_exception_tracker_runtime`
* **Test Name**: `Policy Exception Tracker Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Policy Exception Tracker`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/policy-exception-tracker`)
3. **should_be_visible** (Selector: `policy_exception_tracker-screen`, Value: `None`)
4. **should_be_visible** (Selector: `policy_exception_tracker-title`, Value: `None`)
5. **should_be_visible** (Selector: `policy_exception_tracker-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
