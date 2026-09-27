# SCREEN DATA CONTEXT: training_compliance

Below are the database records from `governance.db` used to configure and build the **Guest - TrainingComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `729`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `training_compliance`
* **Screen Name**: `TrainingComplianceScreen`
* **Route Path**: `/offices/corporate/roles/compliance_manager/training-compliance`
* **Actual File Path**: `apps/primecare_corporate/lib/features/compliance/screens/training_compliance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to training compliance.`
* **User Story**: `As a Guest, I want to access the Training Compliance within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Training Compliance`
* **Acceptance Criteria**:
- The Training Compliance route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `training_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `training_compliance-content` (Type: layout, Required: 1)
* **trainingcompliancescreen_screen** -> `trainingcompliancescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `7000` (Required: 1)
* Component ID: `7001` (Required: 1)
* Component ID: `7002` (Required: 1)
* Component ID: `7003` (Required: 1)
* Component ID: `7004` (Required: 1)
* Component ID: `7005` (Required: 1)

## 7. API / Data Mapping
* API ID: `5111` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_compliance_runtime`
* **Test Name**: `Training Compliance Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/compliance_manager/training-compliance`)
3. **should_be_visible** (Selector: `training_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
