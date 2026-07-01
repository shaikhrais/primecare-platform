# SCREEN DATA CONTEXT: care_plan_review

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - CarePlanReviewScreen** screen.

---

## 1. Screen Record
* **ID**: `526`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `care_plan_review`
* **Screen Name**: `CarePlanReviewScreen`
* **Route Path**: `/offices/clinical/roles/rn/care-plan-review`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/care_plan_review_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to careplanreviewscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the CarePlanReviewScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CarePlanReviewScreen`
* **Acceptance Criteria**:
- The CarePlanReviewScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `care_plan_review-screen` (Type: layout, Required: 1)
* **page_title** -> `care_plan_review-title` (Type: header, Required: 1)
* **primary_content** -> `care_plan_review-content` (Type: layout, Required: 1)
* **careplanreview_btn_1** -> `careplanreview-btn-1` (Type: button, Required: 0)
* **careplanreview_title** -> `careplanreview-title` (Type: header, Required: 0)
* **careplanreview_screen** -> `careplanreview-screen` (Type: layout, Required: 0)
* **careplanreview_btn_2** -> `careplanreview-btn-2` (Type: button, Required: 0)
* **careplanreview_content** -> `careplanreview-content` (Type: layout, Required: 0)
* **careplanreview_loading** -> `careplanreview-loading` (Type: loading, Required: 0)
* **careplanreview_btn_3** -> `careplanreview-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `454` (Required: 1)
* Component ID: `988` (Required: 1)
* Component ID: `1522` (Required: 1)
* Component ID: `5622` (Required: 1)
* Component ID: `5623` (Required: 1)
* Component ID: `5624` (Required: 1)
* Component ID: `5625` (Required: 1)
* Component ID: `5626` (Required: 1)
* Component ID: `5627` (Required: 1)
* Component ID: `5628` (Required: 1)
* Component ID: `5629` (Required: 1)
* Component ID: `5630` (Required: 1)
* Component ID: `5631` (Required: 1)

## 7. API / Data Mapping
* API ID: `4843` (Required: 1)
* API ID: `4844` (Required: 1)
* API ID: `4845` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `care_plan_review_runtime`
* **Test Name**: `CarePlanReviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Care Plan Review`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Care Plan Review`)
4. **click_sidebar_link** (Selector: `None`, Value: `Care Plan Review`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rn/care-plan-review`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
