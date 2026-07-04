# SCREEN DATA CONTEXT: incident_review

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - IncidentReviewScreen** screen.

---

## 1. Screen Record
* **ID**: `527`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `incident_review`
* **Screen Name**: `IncidentReviewScreen`
* **Route Path**: `/offices/clinical/roles/rn/incident-review`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/incident_review_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to incidentreviewscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the IncidentReviewScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IncidentReviewScreen`
* **Acceptance Criteria**:
- The IncidentReviewScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `incident_review-screen` (Type: layout, Required: 1)
* **page_title** -> `incident_review-title` (Type: header, Required: 1)
* **primary_content** -> `incident_review-content` (Type: layout, Required: 1)
* **incidentreview_btn_1** -> `incidentreview-btn-1` (Type: button, Required: 0)
* **incidentreview_screen** -> `incidentreview-screen` (Type: layout, Required: 0)
* **incidentreview_loading** -> `incidentreview-loading` (Type: loading, Required: 0)
* **incidentreview_title** -> `incidentreview-title` (Type: header, Required: 0)
* **incidentreview_content** -> `incidentreview-content` (Type: layout, Required: 0)
* **incidentreview_btn_2** -> `incidentreview-btn-2` (Type: button, Required: 0)
* **incidentreview_btn_3** -> `incidentreview-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `455` (Required: 1)
* Component ID: `989` (Required: 1)
* Component ID: `1523` (Required: 1)
* Component ID: `5632` (Required: 1)
* Component ID: `5633` (Required: 1)
* Component ID: `5634` (Required: 1)
* Component ID: `5635` (Required: 1)
* Component ID: `5636` (Required: 1)
* Component ID: `5637` (Required: 1)
* Component ID: `5638` (Required: 1)
* Component ID: `5639` (Required: 1)
* Component ID: `5640` (Required: 1)
* Component ID: `5641` (Required: 1)

## 7. API / Data Mapping
* API ID: `4846` (Required: 1)
* API ID: `4847` (Required: 1)
* API ID: `4848` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `incident_review_runtime`
* **Test Name**: `IncidentReviewScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `IncidentReviewScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rn/incident-review`)
3. **should_be_visible** (Selector: `incident_review-screen`, Value: `None`)
4. **should_be_visible** (Selector: `incident_review-title`, Value: `None`)
5. **should_be_visible** (Selector: `incident_review-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
