# SCREEN DATA CONTEXT: training_coordinator_compliance

Below are the database records from `governance.db` used to configure and build the **Training Candidate - TrainingCoordinatorComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `273`
* **App ID**: `1`
* **Role ID**: `19`
* **Screen Code**: `training_coordinator_compliance`
* **Screen Name**: `TrainingCoordinatorComplianceScreen`
* **Route Path**: `/staff/training-coordinator-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/training_coordinator_compliance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Training Candidate personnel to oversee, audit, and coordinate operations related to trainingcoordinatorcompliancescreen.`
* **User Story**: `As a Training Candidate, I want to access the TrainingCoordinatorComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TrainingCoordinatorComplianceScreen`
* **Acceptance Criteria**:
- The TrainingCoordinatorComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Candidate access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_coordinator_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `training_coordinator_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `training_coordinator_compliance-content` (Type: layout, Required: 1)
* **trainingcoordinatorcompliance_btn_1** -> `trainingcoordinatorcompliance-btn-1` (Type: button, Required: 0)
* **trainingcoordinatorcompliance_btn_3** -> `trainingcoordinatorcompliance-btn-3` (Type: button, Required: 0)
* **trainingcoordinatorcompliance_screen** -> `trainingcoordinatorcompliance-screen` (Type: layout, Required: 0)
* **trainingcoordinatorcompliance_btn_2** -> `trainingcoordinatorcompliance-btn-2` (Type: button, Required: 0)
* **trainingcoordinatorcompliance_btn_5** -> `trainingcoordinatorcompliance-btn-5` (Type: button, Required: 0)
* **trainingcoordinatorcompliance_title** -> `trainingcoordinatorcompliance-title` (Type: header, Required: 0)
* **trainingcoordinatorcompliance_content** -> `trainingcoordinatorcompliance-content` (Type: layout, Required: 0)
* **trainingcoordinatorcompliance_btn_4** -> `trainingcoordinatorcompliance-btn-4` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `281` (Required: 1)
* Component ID: `815` (Required: 1)
* Component ID: `1349` (Required: 1)
* Component ID: `4035` (Required: 1)
* Component ID: `4036` (Required: 1)
* Component ID: `4037` (Required: 1)
* Component ID: `4038` (Required: 1)
* Component ID: `4039` (Required: 1)
* Component ID: `4040` (Required: 1)
* Component ID: `4041` (Required: 1)

## 7. API / Data Mapping
* API ID: `4594` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_coordinator_compliance_runtime`
* **Test Name**: `TrainingCoordinatorComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TrainingCoordinatorComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training`)
2. **visit** (Selector: `None`, Value: `/staff/training-coordinator-compliance`)
3. **should_be_visible** (Selector: `training_coordinator_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_coordinator_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_coordinator_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
