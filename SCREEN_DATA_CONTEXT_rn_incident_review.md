# SCREEN DATA CONTEXT: rn_incident_review

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnIncidentReviewScreen** screen.

---

## 1. Screen Record
* **ID**: `365`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `rn_incident_review`
* **Screen Name**: `RnIncidentReviewScreen`
* **Route Path**: `/offices/clinical/roles/rn/rn-incident-review`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_incident_review_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `8`
* **Role Code**: `rn`
* **Role Name**: `Registered Nurse (RN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rnincidentreviewscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnIncidentReviewScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnIncidentReviewScreen`
* **Acceptance Criteria**:
- The RnIncidentReviewScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_incident_review-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_incident_review-title` (Type: header, Required: 1)
* **primary_content** -> `rn_incident_review-content` (Type: layout, Required: 1)
* **rnincidentreview_btn_3** -> `rnincidentreview-btn-3` (Type: button, Required: 0)
* **rnincidentreview_btn_1** -> `rnincidentreview-btn-1` (Type: button, Required: 0)
* **rnincidentreview_loading** -> `rnincidentreview-loading` (Type: loading, Required: 0)
* **rnincidentreview_btn_2** -> `rnincidentreview-btn-2` (Type: button, Required: 0)
* **rnincidentreview_title** -> `rnincidentreview-title` (Type: header, Required: 0)
* **rnincidentreview_screen** -> `rnincidentreview-screen` (Type: layout, Required: 0)
* **rnincidentreview_content** -> `rnincidentreview-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `371` (Required: 1)
* Component ID: `905` (Required: 1)
* Component ID: `1439` (Required: 1)
* Component ID: `4824` (Required: 1)
* Component ID: `4825` (Required: 1)
* Component ID: `4826` (Required: 1)
* Component ID: `4827` (Required: 1)
* Component ID: `4828` (Required: 1)
* Component ID: `4829` (Required: 1)
* Component ID: `4830` (Required: 1)
* Component ID: `4831` (Required: 1)
* Component ID: `4832` (Required: 1)
* Component ID: `4833` (Required: 1)

## 7. API / Data Mapping
* API ID: `4722` (Required: 1)
* API ID: `4723` (Required: 1)
* API ID: `4724` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_incident_review_runtime`
* **Test Name**: `RnIncidentReviewScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RnIncidentReviewScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rn/rn-incident-review`)
3. **should_be_visible** (Selector: `rn_incident_review-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_incident_review-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_incident_review-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
