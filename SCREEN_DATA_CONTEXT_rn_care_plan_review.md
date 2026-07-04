# SCREEN DATA CONTEXT: rn_care_plan_review

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnCarePlanReviewScreen** screen.

---

## 1. Screen Record
* **ID**: `364`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `rn_care_plan_review`
* **Screen Name**: `RnCarePlanReviewScreen`
* **Route Path**: `/offices/clinical/roles/rn/rn-care-plan-review`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_care_plan_review_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rncareplanreviewscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnCarePlanReviewScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnCarePlanReviewScreen`
* **Acceptance Criteria**:
- The RnCarePlanReviewScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_care_plan_review-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_care_plan_review-title` (Type: header, Required: 1)
* **primary_content** -> `rn_care_plan_review-content` (Type: layout, Required: 1)
* **rncareplanreview_btn_1** -> `rncareplanreview-btn-1` (Type: button, Required: 0)
* **rncareplanreview_content** -> `rncareplanreview-content` (Type: layout, Required: 0)
* **rncareplanreview_btn_3** -> `rncareplanreview-btn-3` (Type: button, Required: 0)
* **rncareplanreview_title** -> `rncareplanreview-title` (Type: header, Required: 0)
* **rncareplanreview_loading** -> `rncareplanreview-loading` (Type: loading, Required: 0)
* **rncareplanreview_btn_2** -> `rncareplanreview-btn-2` (Type: button, Required: 0)
* **rncareplanreview_screen** -> `rncareplanreview-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `370` (Required: 1)
* Component ID: `904` (Required: 1)
* Component ID: `1438` (Required: 1)
* Component ID: `4814` (Required: 1)
* Component ID: `4815` (Required: 1)
* Component ID: `4816` (Required: 1)
* Component ID: `4817` (Required: 1)
* Component ID: `4818` (Required: 1)
* Component ID: `4819` (Required: 1)
* Component ID: `4820` (Required: 1)
* Component ID: `4821` (Required: 1)
* Component ID: `4822` (Required: 1)
* Component ID: `4823` (Required: 1)

## 7. API / Data Mapping
* API ID: `4719` (Required: 1)
* API ID: `4720` (Required: 1)
* API ID: `4721` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_care_plan_review_runtime`
* **Test Name**: `RnCarePlanReviewScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RnCarePlanReviewScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rn/rn-care-plan-review`)
3. **should_be_visible** (Selector: `rn_care_plan_review-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_care_plan_review-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_care_plan_review-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
