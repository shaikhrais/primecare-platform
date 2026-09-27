# SCREEN DATA CONTEXT: trial_data_collection_c_r_f

Below are the database records from `governance.db` used to configure and build the **Guest - TrialDataCollectionCRFScreen** screen.

---

## 1. Screen Record
* **ID**: `1017`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `trial_data_collection_c_r_f`
* **Screen Name**: `TrialDataCollectionCRFScreen`
* **Route Path**: `/generated/trial-data-collection-c-r-f`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/research/trial_data_collection_crf.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to trial data collection c r f.`
* **User Story**: `As a Guest, I want to access the Trial Data Collection C R F within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Trial Data Collection C R F`
* **Acceptance Criteria**:
- The Trial Data Collection C R F route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `trial_data_collection_c_r_f-screen` (Type: layout, Required: 1)
* **page_title** -> `trial_data_collection_c_r_f-title` (Type: header, Required: 1)
* **primary_content** -> `trial_data_collection_c_r_f-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8583` (Required: 1)
* Component ID: `8584` (Required: 1)
* Component ID: `8585` (Required: 1)
* Component ID: `8586` (Required: 1)
* Component ID: `8587` (Required: 1)

## 7. API / Data Mapping
* API ID: `5483` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `trial_data_collection_c_r_f_runtime`
* **Test Name**: `Trial Data Collection C R F Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Trial Data Collection C R F`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/trial-data-collection-c-r-f`)
3. **should_be_visible** (Selector: `trial_data_collection_c_r_f-screen`, Value: `None`)
4. **should_be_visible** (Selector: `trial_data_collection_c_r_f-title`, Value: `None`)
5. **should_be_visible** (Selector: `trial_data_collection_c_r_f-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
