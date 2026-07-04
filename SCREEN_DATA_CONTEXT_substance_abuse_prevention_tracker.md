# SCREEN DATA CONTEXT: substance_abuse_prevention_tracker

Below are the database records from `governance.db` used to configure and build the **Guest - SubstanceAbusePreventionTrackerScreen** screen.

---

## 1. Screen Record
* **ID**: `1005`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `substance_abuse_prevention_tracker`
* **Screen Name**: `SubstanceAbusePreventionTrackerScreen`
* **Route Path**: `/generated/substance-abuse-prevention-tracker`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/public_health/substance_abuse_prevention_tracker.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to substance abuse prevention tracker.`
* **User Story**: `As a Guest, I want to access the Substance Abuse Prevention Tracker within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Substance Abuse Prevention Tracker`
* **Acceptance Criteria**:
- The Substance Abuse Prevention Tracker route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `substance_abuse_prevention_tracker-screen` (Type: layout, Required: 1)
* **page_title** -> `substance_abuse_prevention_tracker-title` (Type: header, Required: 1)
* **primary_content** -> `substance_abuse_prevention_tracker-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8508` (Required: 1)
* Component ID: `8509` (Required: 1)
* Component ID: `8510` (Required: 1)
* Component ID: `8511` (Required: 1)
* Component ID: `8512` (Required: 1)

## 7. API / Data Mapping
* API ID: `5467` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `substance_abuse_prevention_tracker_runtime`
* **Test Name**: `Substance Abuse Prevention Tracker Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Substance Abuse Prevention Tracker`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/substance-abuse-prevention-tracker`)
3. **should_be_visible** (Selector: `substance_abuse_prevention_tracker-screen`, Value: `None`)
4. **should_be_visible** (Selector: `substance_abuse_prevention_tracker-title`, Value: `None`)
5. **should_be_visible** (Selector: `substance_abuse_prevention_tracker-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
