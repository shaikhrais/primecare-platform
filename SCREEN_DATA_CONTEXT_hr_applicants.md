# SCREEN DATA CONTEXT: hr_applicants

Below are the database records from `governance.db` used to configure and build the **Guest - HrApplicantsScreen** screen.

---

## 1. Screen Record
* **ID**: `964`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `hr_applicants`
* **Screen Name**: `HrApplicantsScreen`
* **Route Path**: `/generated/hr-applicants`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/hr_applicants_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to hr applicants.`
* **User Story**: `As a Guest, I want to access the Hr Applicants within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Hr Applicants`
* **Acceptance Criteria**:
- The Hr Applicants route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_applicants-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_applicants-title` (Type: header, Required: 1)
* **primary_content** -> `hr_applicants-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8254` (Required: 1)
* Component ID: `8255` (Required: 1)
* Component ID: `8256` (Required: 1)
* Component ID: `8257` (Required: 1)
* Component ID: `8258` (Required: 1)
* Component ID: `8259` (Required: 1)

## 7. API / Data Mapping
* API ID: `5402` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_applicants_runtime`
* **Test Name**: `Hr Applicants Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Hr Applicants`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/hr-applicants`)
3. **should_be_visible** (Selector: `hr_applicants-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_applicants-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_applicants-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
