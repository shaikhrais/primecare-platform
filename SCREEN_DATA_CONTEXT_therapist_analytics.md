# SCREEN DATA CONTEXT: therapist_analytics

Below are the database records from `governance.db` used to configure and build the **Therapist - TherapistAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `597`
* **App ID**: `1`
* **Role ID**: `5`
* **Screen Code**: `therapist_analytics`
* **Screen Name**: `TherapistAnalyticsScreen`
* **Route Path**: `/offices/clinical/roles/therapist/analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/therapist_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `5`
* **Role Code**: `therapist`
* **Role Name**: `Therapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Therapist personnel to oversee, audit, and coordinate operations related to therapist analytics.`
* **User Story**: `As a Therapist, I want to access the Therapist Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Therapist Analytics`
* **Acceptance Criteria**:
- The Therapist Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Therapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `therapist_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `therapist_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `therapist_analytics-content` (Type: layout, Required: 1)
* **therapist analytics_btn_3** -> `therapist analytics-btn-3` (Type: button, Required: 0)
* **therapist analytics_btn_1** -> `therapist analytics-btn-1` (Type: button, Required: 0)
* **therapist analytics_loading** -> `therapist analytics-loading` (Type: loading, Required: 0)
* **therapist analytics_title** -> `therapist analytics-title` (Type: header, Required: 0)
* **therapist analytics_content** -> `therapist analytics-content` (Type: layout, Required: 0)
* **therapist analytics_btn_2** -> `therapist analytics-btn-2` (Type: button, Required: 0)
* **therapist analytics_screen** -> `therapist analytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `521` (Required: 1)
* Component ID: `1055` (Required: 1)
* Component ID: `1589` (Required: 1)
* Component ID: `6223` (Required: 1)
* Component ID: `6224` (Required: 1)
* Component ID: `6225` (Required: 1)
* Component ID: `6226` (Required: 1)
* Component ID: `6227` (Required: 1)
* Component ID: `6228` (Required: 1)
* Component ID: `6229` (Required: 1)
* Component ID: `6230` (Required: 1)
* Component ID: `6231` (Required: 1)

## 7. API / Data Mapping
* API ID: `4946` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `therapist_analytics_runtime`
* **Test Name**: `Therapist Analytics Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Therapist Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `therapist`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/therapist/analytics`)
3. **should_be_visible** (Selector: `therapist_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `therapist_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `therapist_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
