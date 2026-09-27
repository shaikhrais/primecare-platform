# SCREEN DATA CONTEXT: trainer_assignments

Below are the database records from `governance.db` used to configure and build the **Guest - TrainerAssignmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `779`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `trainer_assignments`
* **Screen Name**: `TrainerAssignmentsScreen`
* **Route Path**: `/generated/trainer-assignments`
* **Actual File Path**: `apps/primecare_corporate/lib/features/training/screens/trainer_assignments_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to trainer assignments.`
* **User Story**: `As a Guest, I want to access the Trainer Assignments within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Trainer Assignments`
* **Acceptance Criteria**:
- The Trainer Assignments route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `trainer_assignments-screen` (Type: layout, Required: 1)
* **page_title** -> `trainer_assignments-title` (Type: header, Required: 1)
* **primary_content** -> `trainer_assignments-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7269` (Required: 1)
* Component ID: `7270` (Required: 1)
* Component ID: `7271` (Required: 1)
* Component ID: `7272` (Required: 1)
* Component ID: `7273` (Required: 1)

## 7. API / Data Mapping
* API ID: `5168` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `trainer_assignments_runtime`
* **Test Name**: `Trainer Assignments Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Trainer Assignments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/trainer-assignments`)
3. **should_be_visible** (Selector: `trainer_assignments-screen`, Value: `None`)
4. **should_be_visible** (Selector: `trainer_assignments-title`, Value: `None`)
5. **should_be_visible** (Selector: `trainer_assignments-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
