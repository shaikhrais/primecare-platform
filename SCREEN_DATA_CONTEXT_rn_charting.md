# SCREEN DATA CONTEXT: rn_charting

Below are the database records from `governance.db` used to configure and build the **Guest - RnChartingScreen** screen.

---

## 1. Screen Record
* **ID**: `699`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `rn_charting`
* **Screen Name**: `RnChartingScreen`
* **Route Path**: `/generated/rn-charting`
* **Actual File Path**: `apps/primecare_clinic/lib/features/rn/screens/rn_charting_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to rn charting.`
* **User Story**: `As a Guest, I want to access the Rn Charting within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Rn Charting`
* **Acceptance Criteria**:
- The Rn Charting route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_charting-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_charting-title` (Type: header, Required: 1)
* **primary_content** -> `rn_charting-content` (Type: layout, Required: 1)
* **rncharting_content** -> `rncharting-content` (Type: layout, Required: 0)
* **rn_charting_btn_submit_feedback** -> `rn-charting-btn-submit-feedback` (Type: button, Required: 0)
* **rn_charting_btn_refresh** -> `rn-charting-btn-refresh` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `6837` (Required: 1)
* Component ID: `6838` (Required: 1)
* Component ID: `6839` (Required: 1)
* Component ID: `6840` (Required: 1)
* Component ID: `6841` (Required: 1)

## 7. API / Data Mapping
* API ID: `5073` (Required: 1)
* API ID: `5074` (Required: 1)
* API ID: `5075` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_charting_runtime`
* **Test Name**: `Rn Charting Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rn Charting`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/rn-charting`)
3. **should_be_visible** (Selector: `rn_charting-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_charting-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_charting-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
