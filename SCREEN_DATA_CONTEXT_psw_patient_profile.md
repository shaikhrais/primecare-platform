# SCREEN DATA CONTEXT: psw_patient_profile

Below are the database records from `governance.db` used to configure and build the **Guest - PswPatientProfileScreen** screen.

---

## 1. Screen Record
* **ID**: `688`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_patient_profile`
* **Screen Name**: `PswPatientProfileScreen`
* **Route Path**: `/generated/psw-patient-profile`
* **Actual File Path**: `apps/primecare_clinic/lib/features/generated_screens/psw_patient_profile_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw patient profile.`
* **User Story**: `As a Guest, I want to access the Psw Patient Profile within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Patient Profile`
* **Acceptance Criteria**:
- The Psw Patient Profile route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_patient_profile-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_patient_profile-title` (Type: header, Required: 1)
* **primary_content** -> `psw_patient_profile-content` (Type: layout, Required: 1)
* **pswpatientprofilescreen_screen** -> `pswpatientprofilescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6778` (Required: 1)
* Component ID: `6779` (Required: 1)
* Component ID: `6780` (Required: 1)
* Component ID: `6781` (Required: 1)
* Component ID: `6782` (Required: 1)
* Component ID: `6783` (Required: 1)
* Component ID: `6784` (Required: 1)
* Component ID: `6785` (Required: 1)

## 7. API / Data Mapping
* API ID: `5054` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_patient_profile_runtime`
* **Test Name**: `Psw Patient Profile Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Patient Profile`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/psw-patient-profile`)
3. **should_be_visible** (Selector: `psw_patient_profile-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_patient_profile-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_patient_profile-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
