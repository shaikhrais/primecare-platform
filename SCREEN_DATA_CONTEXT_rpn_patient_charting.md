# SCREEN DATA CONTEXT: rpn_patient_charting

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnPatientChartingScreen** screen.

---

## 1. Screen Record
* **ID**: `369`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `rpn_patient_charting`
* **Screen Name**: `RpnPatientChartingScreen`
* **Route Path**: `/offices/clinical/roles/rpn/patient-charting`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_patient_charting_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `55`
* **Role Code**: `rpn`
* **Role Name**: `Registered Practical Nurse (RPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpnpatientchartingscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnPatientChartingScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnPatientChartingScreen`
* **Acceptance Criteria**:
- The RpnPatientChartingScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_patient_charting-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_patient_charting-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_patient_charting-content` (Type: layout, Required: 1)
* **rpnpatientcharting_btn_2** -> `rpnpatientcharting-btn-2` (Type: button, Required: 0)
* **rpnpatientcharting_title** -> `rpnpatientcharting-title` (Type: header, Required: 0)
* **rpnpatientcharting_btn_3** -> `rpnpatientcharting-btn-3` (Type: button, Required: 0)
* **rpnpatientcharting_screen** -> `rpnpatientcharting-screen` (Type: layout, Required: 0)
* **rpnpatientcharting_content** -> `rpnpatientcharting-content` (Type: layout, Required: 0)
* **rpnpatientcharting_btn_1** -> `rpnpatientcharting-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `375` (Required: 1)
* Component ID: `909` (Required: 1)
* Component ID: `1443` (Required: 1)
* Component ID: `4864` (Required: 1)
* Component ID: `4865` (Required: 1)
* Component ID: `4866` (Required: 1)
* Component ID: `4867` (Required: 1)
* Component ID: `4868` (Required: 1)
* Component ID: `4869` (Required: 1)
* Component ID: `4870` (Required: 1)
* Component ID: `4871` (Required: 1)
* Component ID: `4872` (Required: 1)
* Component ID: `4873` (Required: 1)

## 7. API / Data Mapping
* API ID: `4734` (Required: 1)
* API ID: `4735` (Required: 1)
* API ID: `4736` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_patient_charting_runtime`
* **Test Name**: `RpnPatientChartingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RpnPatientChartingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rpn/patient-charting`)
3. **should_be_visible** (Selector: `rpn_patient_charting-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rpn_patient_charting-title`, Value: `None`)
5. **should_be_visible** (Selector: `rpn_patient_charting-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
