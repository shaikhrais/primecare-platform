# SCREEN DATA CONTEXT: clinical_director_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - ClinicalDirectorDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `678`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `clinical_director_dashboard`
* **Screen Name**: `ClinicalDirectorDashboardScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/clinical_director_dashboard.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to clinical director dashboard.`
* **User Story**: `As a Guest, I want to access the Clinical Director Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Clinical Director Dashboard`
* **Acceptance Criteria**:
- The Clinical Director Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_director_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_director_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_director_dashboard-content` (Type: layout, Required: 1)
* **clinical_director_dashboard_elevatedbutton_button_1** -> `clinical_director_dashboard_elevatedbutton_button_1` (Type: button, Required: 0)
* **clinical_director_dashboard_iconbutton_button_1** -> `clinical_director_dashboard_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `6720` (Required: 1)
* Component ID: `6721` (Required: 1)
* Component ID: `6722` (Required: 1)
* Component ID: `6723` (Required: 1)
* Component ID: `6724` (Required: 1)
* Component ID: `6725` (Required: 1)
* Component ID: `6726` (Required: 1)
* Component ID: `6727` (Required: 1)
* Component ID: `6728` (Required: 1)
* Component ID: `6729` (Required: 1)

## 7. API / Data Mapping
* API ID: `5040` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_director_dashboard_runtime`
* **Test Name**: `Clinical Director Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Director Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/dashboard`)
3. **should_be_visible** (Selector: `clinical_director_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_director_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_director_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
