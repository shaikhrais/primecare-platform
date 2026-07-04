# SCREEN DATA CONTEXT: clinical_director_quality_metrics

Below are the database records from `governance.db` used to configure and build the **Guest - ClinicalDirectorQualityMetricsScreen** screen.

---

## 1. Screen Record
* **ID**: `679`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `clinical_director_quality_metrics`
* **Screen Name**: `ClinicalDirectorQualityMetricsScreen`
* **Route Path**: `/generated/clinical-director-quality-metrics`
* **Actual File Path**: `apps/primecare_clinic/lib/features/generated_screens/clinical_director_quality_metrics_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to clinical director quality metrics.`
* **User Story**: `As a Guest, I want to access the Clinical Director Quality Metrics within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Clinical Director Quality Metrics`
* **Acceptance Criteria**:
- The Clinical Director Quality Metrics route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_director_quality_metrics-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_director_quality_metrics-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_director_quality_metrics-content` (Type: layout, Required: 1)
* **clinicaldirectorqualitymetricsscreen_screen** -> `clinicaldirectorqualitymetricsscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6730` (Required: 1)
* Component ID: `6731` (Required: 1)
* Component ID: `6732` (Required: 1)
* Component ID: `6733` (Required: 1)
* Component ID: `6734` (Required: 1)

## 7. API / Data Mapping
* API ID: `5041` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_director_quality_metrics_runtime`
* **Test Name**: `Clinical Director Quality Metrics Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Director Quality Metrics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/clinical-director-quality-metrics`)
3. **should_be_visible** (Selector: `clinical_director_quality_metrics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_director_quality_metrics-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_director_quality_metrics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
