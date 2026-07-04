# SCREEN DATA CONTEXT: training_hub_compliance

Below are the database records from `governance.db` used to configure and build the **Training Candidate - TrainingHubComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `151`
* **App ID**: `1`
* **Role ID**: `19`
* **Screen Code**: `training_hub_compliance`
* **Screen Name**: `TrainingHubComplianceScreen`
* **Route Path**: `/common/training-hub-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/training_hub_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `19`
* **Role Code**: `training`
* **Role Name**: `Training Candidate`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Training Candidate personnel to oversee, audit, and coordinate operations related to traininghubcompliancescreen.`
* **User Story**: `As a Training Candidate, I want to access the TrainingHubComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TrainingHubComplianceScreen`
* **Acceptance Criteria**:
- The TrainingHubComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Candidate access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_hub_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `training_hub_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `training_hub_compliance-content` (Type: layout, Required: 1)
* **traininghubcompliance_btn_1** -> `traininghubcompliance-btn-1` (Type: button, Required: 0)
* **traininghubcompliance_title** -> `traininghubcompliance-title` (Type: header, Required: 0)
* **traininghubcompliance_screen** -> `traininghubcompliance-screen` (Type: layout, Required: 0)
* **traininghubcompliance_btn_2** -> `traininghubcompliance-btn-2` (Type: button, Required: 0)
* **traininghubcompliance_btn_3** -> `traininghubcompliance-btn-3` (Type: button, Required: 0)
* **traininghubcompliance_content** -> `traininghubcompliance-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `159` (Required: 1)
* Component ID: `693` (Required: 1)
* Component ID: `1227` (Required: 1)
* Component ID: `2897` (Required: 1)
* Component ID: `2898` (Required: 1)
* Component ID: `2899` (Required: 1)
* Component ID: `2900` (Required: 1)
* Component ID: `2901` (Required: 1)
* Component ID: `2902` (Required: 1)

## 7. API / Data Mapping
* API ID: `4434` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_hub_compliance_runtime`
* **Test Name**: `TrainingHubComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TrainingHubComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training`)
2. **visit** (Selector: `None`, Value: `/common/training-hub-compliance`)
3. **should_be_visible** (Selector: `training_hub_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_hub_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_hub_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
