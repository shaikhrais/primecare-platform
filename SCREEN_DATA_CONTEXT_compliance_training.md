# SCREEN DATA CONTEXT: compliance_training

Below are the database records from `governance.db` used to configure and build the **Guest - ComplianceTrainingScreen** screen.

---

## 1. Screen Record
* **ID**: `775`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `compliance_training`
* **Screen Name**: `ComplianceTrainingScreen`
* **Route Path**: `/generated/compliance-training`
* **Actual File Path**: `apps/primecare_corporate/lib/features/training/screens/compliance_training_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to compliance training.`
* **User Story**: `As a Guest, I want to access the Compliance Training within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Compliance Training`
* **Acceptance Criteria**:
- The Compliance Training route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_training-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_training-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_training-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7252` (Required: 1)
* Component ID: `7253` (Required: 1)
* Component ID: `7254` (Required: 1)
* Component ID: `7255` (Required: 1)
* Component ID: `7256` (Required: 1)

## 7. API / Data Mapping
* API ID: `5165` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_training_runtime`
* **Test Name**: `Compliance Training Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Training`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/compliance-training`)
3. **should_be_visible** (Selector: `compliance_training-screen`, Value: `None`)
4. **should_be_visible** (Selector: `compliance_training-title`, Value: `None`)
5. **should_be_visible** (Selector: `compliance_training-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
