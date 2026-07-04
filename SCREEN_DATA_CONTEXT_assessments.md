# SCREEN DATA CONTEXT: assessments

Below are the database records from `governance.db` used to configure and build the **Guest - AssessmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `772`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `assessments`
* **Screen Name**: `AssessmentsScreen`
* **Route Path**: `/generated/assessments`
* **Actual File Path**: `apps/primecare_corporate/lib/features/training/screens/assessments_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to assessments.`
* **User Story**: `As a Guest, I want to access the Assessments within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Assessments`
* **Acceptance Criteria**:
- The Assessments route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `assessments-screen` (Type: layout, Required: 1)
* **page_title** -> `assessments-title` (Type: header, Required: 1)
* **primary_content** -> `assessments-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7240` (Required: 1)
* Component ID: `7241` (Required: 1)
* Component ID: `7242` (Required: 1)
* Component ID: `7243` (Required: 1)

## 7. API / Data Mapping
* API ID: `5162` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `assessments_runtime`
* **Test Name**: `Assessments Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Assessments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/assessments`)
3. **should_be_visible** (Selector: `assessments-screen`, Value: `None`)
4. **should_be_visible** (Selector: `assessments-title`, Value: `None`)
5. **should_be_visible** (Selector: `assessments-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
