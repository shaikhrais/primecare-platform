# SCREEN DATA CONTEXT: shift_report

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - ShiftReportScreen** screen.

---

## 1. Screen Record
* **ID**: `528`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `shift_report`
* **Screen Name**: `ShiftReportScreen`
* **Route Path**: `/offices/clinical/roles/rn/shift-report`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/shift_report_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `8`
* **Role Code**: `rn`
* **Role Name**: `Registered Nurse (RN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to shiftreportscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the ShiftReportScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ShiftReportScreen`
* **Acceptance Criteria**:
- The ShiftReportScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `shift_report-screen` (Type: layout, Required: 1)
* **page_title** -> `shift_report-title` (Type: header, Required: 1)
* **primary_content** -> `shift_report-content` (Type: layout, Required: 1)
* **shiftreport_title** -> `shiftreport-title` (Type: header, Required: 0)
* **shiftreport_btn_1** -> `shiftreport-btn-1` (Type: button, Required: 0)
* **shiftreport_btn_2** -> `shiftreport-btn-2` (Type: button, Required: 0)
* **shiftreport_content** -> `shiftreport-content` (Type: layout, Required: 0)
* **shiftreport_btn_3** -> `shiftreport-btn-3` (Type: button, Required: 0)
* **shiftreport_loading** -> `shiftreport-loading` (Type: loading, Required: 0)
* **shiftreport_screen** -> `shiftreport-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `456` (Required: 1)
* Component ID: `990` (Required: 1)
* Component ID: `1524` (Required: 1)
* Component ID: `5642` (Required: 1)
* Component ID: `5643` (Required: 1)
* Component ID: `5644` (Required: 1)
* Component ID: `5645` (Required: 1)
* Component ID: `5646` (Required: 1)
* Component ID: `5647` (Required: 1)
* Component ID: `5648` (Required: 1)
* Component ID: `5649` (Required: 1)
* Component ID: `5650` (Required: 1)
* Component ID: `5651` (Required: 1)

## 7. API / Data Mapping
* API ID: `4849` (Required: 1)
* API ID: `4850` (Required: 1)
* API ID: `4851` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `shift_report_runtime`
* **Test Name**: `ShiftReportScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ShiftReportScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rn/shift-report`)
3. **should_be_visible** (Selector: `shift_report-screen`, Value: `None`)
4. **should_be_visible** (Selector: `shift_report-title`, Value: `None`)
5. **should_be_visible** (Selector: `shift_report-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
