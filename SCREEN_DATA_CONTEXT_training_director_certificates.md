# SCREEN DATA CONTEXT: training_director_certificates

Below are the database records from `governance.db` used to configure and build the **Guest - TrainingDirectorCertificatesScreen** screen.

---

## 1. Screen Record
* **ID**: `762`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `training_director_certificates`
* **Screen Name**: `TrainingDirectorCertificatesScreen`
* **Route Path**: `/offices/corporate/roles/training_director/certificates`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/training_director_certificates_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to training director certificates.`
* **User Story**: `As a Guest, I want to access the Training Director Certificates within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Training Director Certificates`
* **Acceptance Criteria**:
- The Training Director Certificates route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_director_certificates-screen` (Type: layout, Required: 1)
* **page_title** -> `training_director_certificates-title` (Type: header, Required: 1)
* **primary_content** -> `training_director_certificates-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7187` (Required: 1)
* Component ID: `7188` (Required: 1)
* Component ID: `7189` (Required: 1)
* Component ID: `7190` (Required: 1)
* Component ID: `7191` (Required: 1)

## 7. API / Data Mapping
* API ID: `5152` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_director_certificates_runtime`
* **Test Name**: `Training Director Certificates Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Director Certificates`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/training_director/certificates`)
3. **should_be_visible** (Selector: `training_director_certificates-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_director_certificates-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_director_certificates-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
