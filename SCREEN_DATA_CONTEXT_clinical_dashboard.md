# SCREEN DATA CONTEXT: clinical_dashboard

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `3`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `clinical_dashboard`
* **Screen Name**: `ClinicalDashboardScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/dashboard-dup-1`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/clinical_dashboard.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `6`
* **Role Code**: `clinical_director`
* **Role Name**: `Clinical Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicaldashboardscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalDashboardScreen`
* **Acceptance Criteria**:
- The ClinicalDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `11` (Required: 1)
* Component ID: `545` (Required: 1)
* Component ID: `1079` (Required: 1)
* Component ID: `1625` (Required: 1)
* Component ID: `1626` (Required: 1)
* Component ID: `1627` (Required: 1)
* Component ID: `1628` (Required: 1)
* Component ID: `1629` (Required: 1)
* Component ID: `1630` (Required: 1)
* Component ID: `1631` (Required: 1)
* Component ID: `1632` (Required: 1)
* Component ID: `1633` (Required: 1)
* Component ID: `1634` (Required: 1)

## 7. API / Data Mapping
* API ID: `4252` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_dashboard_runtime`
* **Test Name**: `ClinicalDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClinicalDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/dashboard-dup-1`)
3. **should_be_visible** (Selector: `clinical_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
