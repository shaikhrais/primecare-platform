# SCREEN DATA CONTEXT: claims_processing

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - ClaimsProcessingScreen** screen.

---

## 1. Screen Record
* **ID**: `517`
* **App ID**: `5`
* **Role ID**: `59`
* **Screen Code**: `claims_processing`
* **Screen Name**: `ClaimsProcessingScreen`
* **Route Path**: `/staff/claims-processing`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/claims_processing_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to claimsprocessingscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the ClaimsProcessingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClaimsProcessingScreen`
* **Acceptance Criteria**:
- The ClaimsProcessingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `claims_processing-screen` (Type: layout, Required: 1)
* **page_title** -> `claims_processing-title` (Type: header, Required: 1)
* **primary_content** -> `claims_processing-content` (Type: layout, Required: 1)
* **claimsprocessing_screen** -> `claimsprocessing-screen` (Type: layout, Required: 0)
* **claimsprocessing_loading** -> `claimsprocessing-loading` (Type: loading, Required: 0)
* **claimsprocessing_btn_3** -> `claimsprocessing-btn-3` (Type: button, Required: 0)
* **claimsprocessing_content** -> `claimsprocessing-content` (Type: layout, Required: 0)
* **claimsprocessing_btn_2** -> `claimsprocessing-btn-2` (Type: button, Required: 0)
* **claimsprocessing_title** -> `claimsprocessing-title` (Type: header, Required: 0)
* **claimsprocessing_btn_5** -> `claimsprocessing-btn-5` (Type: button, Required: 0)
* **claimsprocessing_btn_1** -> `claimsprocessing-btn-1` (Type: button, Required: 0)
* **claimsprocessing_btn_4** -> `claimsprocessing-btn-4` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `446` (Required: 1)
* Component ID: `980` (Required: 1)
* Component ID: `1514` (Required: 1)
* Component ID: `5546` (Required: 1)
* Component ID: `5547` (Required: 1)
* Component ID: `5548` (Required: 1)
* Component ID: `5549` (Required: 1)
* Component ID: `5550` (Required: 1)
* Component ID: `5551` (Required: 1)
* Component ID: `5552` (Required: 1)
* Component ID: `5553` (Required: 1)
* Component ID: `5554` (Required: 1)
* Component ID: `5555` (Required: 1)

## 7. API / Data Mapping
* API ID: `4833` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `claims_processing_runtime`
* **Test Name**: `ClaimsProcessingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClaimsProcessingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/staff/claims-processing`)
3. **should_be_visible** (Selector: `claims_processing-screen`, Value: `None`)
4. **should_be_visible** (Selector: `claims_processing-title`, Value: `None`)
5. **should_be_visible** (Selector: `claims_processing-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
