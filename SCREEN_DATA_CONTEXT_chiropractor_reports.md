# SCREEN DATA CONTEXT: chiropractor_reports

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `297`
* **App ID**: `6`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_reports`
* **Screen Name**: `ChiropractorReportsScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/reports`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_reports_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorreportsscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorReportsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorReportsScreen`
* **Acceptance Criteria**:
- The ChiropractorReportsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_reports-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_reports-content` (Type: layout, Required: 1)
* **chiropractorreports_screen** -> `chiropractorreports-screen` (Type: layout, Required: 0)
* **chiropractorreports_title** -> `chiropractorreports-title` (Type: header, Required: 0)
* **chiropractorreports_content** -> `chiropractorreports-content` (Type: layout, Required: 0)
* **chiropractorreports_btn_3** -> `chiropractorreports-btn-3` (Type: button, Required: 0)
* **chiropractorreports_btn_2** -> `chiropractorreports-btn-2` (Type: button, Required: 0)
* **chiropractorreports_btn_1** -> `chiropractorreports-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `305` (Required: 1)
* Component ID: `839` (Required: 1)
* Component ID: `1373` (Required: 1)
* Component ID: `4242` (Required: 1)
* Component ID: `4243` (Required: 1)
* Component ID: `4244` (Required: 1)
* Component ID: `4245` (Required: 1)
* Component ID: `4246` (Required: 1)
* Component ID: `4247` (Required: 1)
* Component ID: `4248` (Required: 1)

## 7. API / Data Mapping
* API ID: `4624` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_reports_runtime`
* **Test Name**: `ChiropractorReportsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ChiropractorReportsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/reports`)
3. **should_be_visible** (Selector: `chiropractor_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `chiropractor_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `chiropractor_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
