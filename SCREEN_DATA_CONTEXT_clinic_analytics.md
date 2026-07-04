# SCREEN DATA CONTEXT: clinic_analytics

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `95`
* **App ID**: `1`
* **Role ID**: `6`
* **Screen Code**: `clinic_analytics`
* **Screen Name**: `ClinicAnalyticsScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/clinic-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/clinic_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `6`
* **Role Code**: `clinical_director`
* **Role Name**: `Clinical Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicanalyticsscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicAnalyticsScreen`
* **Acceptance Criteria**:
- The ClinicAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinic_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `clinic_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `clinic_analytics-content` (Type: layout, Required: 1)
* **clinicanalytics_btn_1** -> `clinicanalytics-btn-1` (Type: button, Required: 0)
* **clinicanalytics_content** -> `clinicanalytics-content` (Type: layout, Required: 0)
* **clinicanalytics_title** -> `clinicanalytics-title` (Type: header, Required: 0)
* **clinicanalytics_btn_2** -> `clinicanalytics-btn-2` (Type: button, Required: 0)
* **clinicanalytics_screen** -> `clinicanalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `103` (Required: 1)
* Component ID: `637` (Required: 1)
* Component ID: `1171` (Required: 1)
* Component ID: `2432` (Required: 1)
* Component ID: `2433` (Required: 1)
* Component ID: `2434` (Required: 1)

## 7. API / Data Mapping
* API ID: `4372` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinic_analytics_runtime`
* **Test Name**: `ClinicAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClinicAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/clinic-analytics`)
3. **should_be_visible** (Selector: `clinic_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinic_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinic_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
