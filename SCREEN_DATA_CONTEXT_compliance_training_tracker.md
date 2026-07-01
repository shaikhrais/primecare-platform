# SCREEN DATA CONTEXT: compliance_training_tracker

Below are the database records from `governance.db` used to configure and build the **Guest - ComplianceTrainingTrackerScreen** screen.

---

## 1. Screen Record
* **ID**: `905`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `compliance_training_tracker`
* **Screen Name**: `ComplianceTrainingTrackerScreen`
* **Route Path**: `/generated/compliance-training-tracker`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/compliance_training_tracker.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to compliance training tracker.`
* **User Story**: `As a Guest, I want to access the Compliance Training Tracker within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Compliance Training Tracker`
* **Acceptance Criteria**:
- The Compliance Training Tracker route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_training_tracker-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_training_tracker-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_training_tracker-content` (Type: layout, Required: 1)
* **compliance_training_tracker_iconbutton_button_1** -> `compliance_training_tracker_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7980` (Required: 1)
* Component ID: `7981` (Required: 1)
* Component ID: `7982` (Required: 1)
* Component ID: `7983` (Required: 1)

## 7. API / Data Mapping
* API ID: `5323` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_training_tracker_runtime`
* **Test Name**: `Compliance Training Tracker Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Training Tracker`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Compliance Training Tracker`)
4. **click_sidebar_link** (Selector: `None`, Value: `Compliance Training Tracker`)
5. **check_url** (Selector: `None`, Value: `/generated/compliance-training-tracker`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
