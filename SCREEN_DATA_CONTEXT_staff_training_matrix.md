# SCREEN DATA CONTEXT: staff_training_matrix

Below are the database records from `governance.db` used to configure and build the **Guest - StaffTrainingMatrixScreen** screen.

---

## 1. Screen Record
* **ID**: `778`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `staff_training_matrix`
* **Screen Name**: `StaffTrainingMatrixScreen`
* **Route Path**: `/generated/staff-training-matrix`
* **Actual File Path**: `apps/primecare_corporate/lib/features/training/screens/staff_training_matrix_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to staff training matrix.`
* **User Story**: `As a Guest, I want to access the Staff Training Matrix within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Staff Training Matrix`
* **Acceptance Criteria**:
- The Staff Training Matrix route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `staff_training_matrix-screen` (Type: layout, Required: 1)
* **page_title** -> `staff_training_matrix-title` (Type: header, Required: 1)
* **primary_content** -> `staff_training_matrix-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7264` (Required: 1)
* Component ID: `7265` (Required: 1)
* Component ID: `7266` (Required: 1)
* Component ID: `7267` (Required: 1)
* Component ID: `7268` (Required: 1)

## 7. API / Data Mapping
* API ID: `5167` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `staff_training_matrix_runtime`
* **Test Name**: `Staff Training Matrix Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Staff Training Matrix`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/staff-training-matrix`)
3. **should_be_visible** (Selector: `staff_training_matrix-screen`, Value: `None`)
4. **should_be_visible** (Selector: `staff_training_matrix-title`, Value: `None`)
5. **should_be_visible** (Selector: `staff_training_matrix-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
