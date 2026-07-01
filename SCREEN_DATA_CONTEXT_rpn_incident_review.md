# SCREEN DATA CONTEXT: rpn_incident_review

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnIncidentReviewScreen** screen.

---

## 1. Screen Record
* **ID**: `373`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `rpn_incident_review`
* **Screen Name**: `RpnIncidentReviewScreen`
* **Route Path**: `/offices/clinical/roles/rpn/rpn-incident-review`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_incident_review_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `55`
* **Role Code**: `rpn`
* **Role Name**: `Registered Practical Nurse (RPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpnincidentreviewscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnIncidentReviewScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnIncidentReviewScreen`
* **Acceptance Criteria**:
- The RpnIncidentReviewScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_incident_review-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_incident_review-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_incident_review-content` (Type: layout, Required: 1)
* **rpnincidentreview_loading** -> `rpnincidentreview-loading` (Type: loading, Required: 0)
* **rpnincidentreview_screen** -> `rpnincidentreview-screen` (Type: layout, Required: 0)
* **rpnincidentreview_btn_2** -> `rpnincidentreview-btn-2` (Type: button, Required: 0)
* **rpnincidentreview_btn_1** -> `rpnincidentreview-btn-1` (Type: button, Required: 0)
* **rpnincidentreview_btn_3** -> `rpnincidentreview-btn-3` (Type: button, Required: 0)
* **rpnincidentreview_content** -> `rpnincidentreview-content` (Type: layout, Required: 0)
* **rpnincidentreview_title** -> `rpnincidentreview-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `379` (Required: 1)
* Component ID: `913` (Required: 1)
* Component ID: `1447` (Required: 1)
* Component ID: `4904` (Required: 1)
* Component ID: `4905` (Required: 1)
* Component ID: `4906` (Required: 1)
* Component ID: `4907` (Required: 1)
* Component ID: `4908` (Required: 1)
* Component ID: `4909` (Required: 1)
* Component ID: `4910` (Required: 1)
* Component ID: `4911` (Required: 1)
* Component ID: `4912` (Required: 1)
* Component ID: `4913` (Required: 1)

## 7. API / Data Mapping
* API ID: `4746` (Required: 1)
* API ID: `4747` (Required: 1)
* API ID: `4748` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_incident_review_runtime`
* **Test Name**: `RpnIncidentReviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rpn Incident Review`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Rpn Incident Review`)
4. **click_sidebar_link** (Selector: `None`, Value: `Rpn Incident Review`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/rpn-incident-review`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
