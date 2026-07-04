# SCREEN DATA CONTEXT: vitals_tracking

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - VitalsTrackingScreen** screen.

---

## 1. Screen Record
* **ID**: `530`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `vitals_tracking`
* **Screen Name**: `VitalsTrackingScreen`
* **Route Path**: `/offices/clinical/roles/rpn/vitals-tracking`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/vitals_tracking_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to vitalstrackingscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the VitalsTrackingScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `VitalsTrackingScreen`
* **Acceptance Criteria**:
- The VitalsTrackingScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `vitals_tracking-screen` (Type: layout, Required: 1)
* **page_title** -> `vitals_tracking-title` (Type: header, Required: 1)
* **primary_content** -> `vitals_tracking-content` (Type: layout, Required: 1)
* **vitalstracking_content** -> `vitalstracking-content` (Type: layout, Required: 0)
* **vitalstracking_btn_1** -> `vitalstracking-btn-1` (Type: button, Required: 0)
* **vitalstracking_loading** -> `vitalstracking-loading` (Type: loading, Required: 0)
* **vitalstracking_screen** -> `vitalstracking-screen` (Type: layout, Required: 0)
* **vitalstracking_btn_3** -> `vitalstracking-btn-3` (Type: button, Required: 0)
* **vitalstracking_title** -> `vitalstracking-title` (Type: header, Required: 0)
* **vitalstracking_btn_2** -> `vitalstracking-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `458` (Required: 1)
* Component ID: `992` (Required: 1)
* Component ID: `1526` (Required: 1)
* Component ID: `5662` (Required: 1)
* Component ID: `5663` (Required: 1)
* Component ID: `5664` (Required: 1)
* Component ID: `5665` (Required: 1)
* Component ID: `5666` (Required: 1)
* Component ID: `5667` (Required: 1)
* Component ID: `5668` (Required: 1)
* Component ID: `5669` (Required: 1)
* Component ID: `5670` (Required: 1)
* Component ID: `5671` (Required: 1)

## 7. API / Data Mapping
* API ID: `4855` (Required: 1)
* API ID: `4856` (Required: 1)
* API ID: `4857` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `vitals_tracking_runtime`
* **Test Name**: `VitalsTrackingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `VitalsTrackingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rpn/vitals-tracking`)
3. **should_be_visible** (Selector: `vitals_tracking-screen`, Value: `None`)
4. **should_be_visible** (Selector: `vitals_tracking-title`, Value: `None`)
5. **should_be_visible** (Selector: `vitals_tracking-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
