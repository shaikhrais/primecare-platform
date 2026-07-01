# SCREEN DATA CONTEXT: informed_consent_tracker

Below are the database records from `governance.db` used to configure and build the **Guest - InformedConsentTrackerScreen** screen.

---

## 1. Screen Record
* **ID**: `1012`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `informed_consent_tracker`
* **Screen Name**: `InformedConsentTrackerScreen`
* **Route Path**: `/generated/informed-consent-tracker`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/research/informed_consent_tracker.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to informed consent tracker.`
* **User Story**: `As a Guest, I want to access the Informed Consent Tracker within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Informed Consent Tracker`
* **Acceptance Criteria**:
- The Informed Consent Tracker route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `informed_consent_tracker-screen` (Type: layout, Required: 1)
* **page_title** -> `informed_consent_tracker-title` (Type: header, Required: 1)
* **primary_content** -> `informed_consent_tracker-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8549` (Required: 1)
* Component ID: `8550` (Required: 1)
* Component ID: `8551` (Required: 1)
* Component ID: `8552` (Required: 1)
* Component ID: `8553` (Required: 1)
* Component ID: `8554` (Required: 1)

## 7. API / Data Mapping
* API ID: `5476` (Required: 1)
* API ID: `5477` (Required: 1)
* API ID: `5478` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `informed_consent_tracker_runtime`
* **Test Name**: `Informed Consent Tracker Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Informed Consent Tracker`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Informed Consent Tracker`)
4. **click_sidebar_link** (Selector: `None`, Value: `Informed Consent Tracker`)
5. **check_url** (Selector: `None`, Value: `/generated/informed-consent-tracker`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
