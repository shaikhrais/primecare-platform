# SCREEN DATA CONTEXT: training_coordinator_materials

Below are the database records from `governance.db` used to configure and build the **Guest - TrainingCoordinatorMaterialsScreen** screen.

---

## 1. Screen Record
* **ID**: `890`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `training_coordinator_materials`
* **Screen Name**: `TrainingCoordinatorMaterialsScreen`
* **Route Path**: `/generated/training-coordinator-materials`
* **Actual File Path**: `apps/primecare_support/lib/features/generated_screens/training_coordinator_materials_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to training coordinator materials.`
* **User Story**: `As a Guest, I want to access the Training Coordinator Materials within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Training Coordinator Materials`
* **Acceptance Criteria**:
- The Training Coordinator Materials route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_coordinator_materials-screen` (Type: layout, Required: 1)
* **page_title** -> `training_coordinator_materials-title` (Type: header, Required: 1)
* **primary_content** -> `training_coordinator_materials-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7897` (Required: 1)
* Component ID: `7898` (Required: 1)
* Component ID: `7899` (Required: 1)
* Component ID: `7900` (Required: 1)

## 7. API / Data Mapping
* API ID: `5304` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_coordinator_materials_runtime`
* **Test Name**: `Training Coordinator Materials Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Coordinator Materials`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/training-coordinator-materials`)
3. **should_be_visible** (Selector: `training_coordinator_materials-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_coordinator_materials-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_coordinator_materials-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
