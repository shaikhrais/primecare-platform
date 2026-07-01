# SCREEN DATA CONTEXT: telemedicine_prescription_pad

Below are the database records from `governance.db` used to configure and build the **Guest - TelemedicinePrescriptionPadScreen** screen.

---

## 1. Screen Record
* **ID**: `1026`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `telemedicine_prescription_pad`
* **Screen Name**: `TelemedicinePrescriptionPadScreen`
* **Route Path**: `/generated/telemedicine-prescription-pad`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/telehealth/telemedicine_prescription_pad.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to telemedicine prescription pad.`
* **User Story**: `As a Guest, I want to access the Telemedicine Prescription Pad within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Telemedicine Prescription Pad`
* **Acceptance Criteria**:
- The Telemedicine Prescription Pad route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `telemedicine_prescription_pad-screen` (Type: layout, Required: 1)
* **page_title** -> `telemedicine_prescription_pad-title` (Type: header, Required: 1)
* **primary_content** -> `telemedicine_prescription_pad-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8640` (Required: 1)
* Component ID: `8641` (Required: 1)
* Component ID: `8642` (Required: 1)
* Component ID: `8643` (Required: 1)
* Component ID: `8644` (Required: 1)
* Component ID: `8645` (Required: 1)
* Component ID: `8646` (Required: 1)

## 7. API / Data Mapping
* API ID: `5492` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `telemedicine_prescription_pad_runtime`
* **Test Name**: `Telemedicine Prescription Pad Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Telemedicine Prescription Pad`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Telemedicine Prescription Pad`)
4. **click_sidebar_link** (Selector: `None`, Value: `Telemedicine Prescription Pad`)
5. **check_url** (Selector: `None`, Value: `/generated/telemedicine-prescription-pad`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
