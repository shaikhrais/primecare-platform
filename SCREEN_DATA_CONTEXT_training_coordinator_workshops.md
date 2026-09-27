# SCREEN DATA CONTEXT: training_coordinator_workshops

Below are the database records from `governance.db` used to configure and build the **Guest - TrainingCoordinatorWorkshopsScreen** screen.

---

## 1. Screen Record
* **ID**: `894`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `training_coordinator_workshops`
* **Screen Name**: `TrainingCoordinatorWorkshopsScreen`
* **Route Path**: `/generated/training-coordinator-workshops`
* **Actual File Path**: `apps/primecare_support/lib/features/generated_screens/training_coordinator_workshops_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to training coordinator workshops.`
* **User Story**: `As a Guest, I want to access the Training Coordinator Workshops within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Training Coordinator Workshops`
* **Acceptance Criteria**:
- The Training Coordinator Workshops route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_coordinator_workshops-screen` (Type: layout, Required: 1)
* **page_title** -> `training_coordinator_workshops-title` (Type: header, Required: 1)
* **primary_content** -> `training_coordinator_workshops-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7917` (Required: 1)
* Component ID: `7918` (Required: 1)
* Component ID: `7919` (Required: 1)
* Component ID: `7920` (Required: 1)
* Component ID: `7921` (Required: 1)

## 7. API / Data Mapping
* API ID: `5308` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_coordinator_workshops_runtime`
* **Test Name**: `Training Coordinator Workshops Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Coordinator Workshops`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/training-coordinator-workshops`)
3. **should_be_visible** (Selector: `training_coordinator_workshops-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_coordinator_workshops-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_coordinator_workshops-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
