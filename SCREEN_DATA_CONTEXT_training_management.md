# SCREEN DATA CONTEXT: training_management

Below are the database records from `governance.db` used to configure and build the **HR Director - TrainingManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `493`
* **App ID**: `5`
* **Role ID**: `27`
* **Screen Code**: `training_management`
* **Screen Name**: `TrainingManagementScreen`
* **Route Path**: `/management/training-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/training_management_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable HR Director personnel to oversee, audit, and coordinate operations related to trainingmanagementscreen.`
* **User Story**: `As a HR Director, I want to access the TrainingManagementScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TrainingManagementScreen`
* **Acceptance Criteria**:
- The TrainingManagementScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_management-screen` (Type: layout, Required: 1)
* **page_title** -> `training_management-title` (Type: header, Required: 1)
* **primary_content** -> `training_management-content` (Type: layout, Required: 1)
* **trainingmanagement_btn_1** -> `trainingmanagement-btn-1` (Type: button, Required: 0)
* **trainingmanagement_title** -> `trainingmanagement-title` (Type: header, Required: 0)
* **trainingmanagement_screen** -> `trainingmanagement-screen` (Type: layout, Required: 0)
* **trainingmanagement_content** -> `trainingmanagement-content` (Type: layout, Required: 0)
* **trainingmanagement_btn_2** -> `trainingmanagement-btn-2` (Type: button, Required: 0)
* **trainingmanagement_btn_3** -> `trainingmanagement-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `422` (Required: 1)
* Component ID: `956` (Required: 1)
* Component ID: `1490` (Required: 1)
* Component ID: `5313` (Required: 1)
* Component ID: `5314` (Required: 1)
* Component ID: `5315` (Required: 1)
* Component ID: `5316` (Required: 1)
* Component ID: `5317` (Required: 1)
* Component ID: `5318` (Required: 1)
* Component ID: `5319` (Required: 1)
* Component ID: `5320` (Required: 1)
* Component ID: `5321` (Required: 1)
* Component ID: `5322` (Required: 1)

## 7. API / Data Mapping
* API ID: `4810` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_management_runtime`
* **Test Name**: `TrainingManagementScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TrainingManagementScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **visit** (Selector: `None`, Value: `/management/training-management`)
3. **should_be_visible** (Selector: `training_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
