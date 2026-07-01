# SCREEN DATA CONTEXT: rpn_care_plan_review

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnCarePlanReviewScreen** screen.

---

## 1. Screen Record
* **ID**: `372`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `rpn_care_plan_review`
* **Screen Name**: `RpnCarePlanReviewScreen`
* **Route Path**: `/offices/clinical/roles/rpn/rpn-care-plan-review`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_care_plan_review_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpncareplanreviewscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnCarePlanReviewScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnCarePlanReviewScreen`
* **Acceptance Criteria**:
- The RpnCarePlanReviewScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_care_plan_review-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_care_plan_review-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_care_plan_review-content` (Type: layout, Required: 1)
* **rpncareplanreview_title** -> `rpncareplanreview-title` (Type: header, Required: 0)
* **rpncareplanreview_btn_2** -> `rpncareplanreview-btn-2` (Type: button, Required: 0)
* **rpncareplanreview_content** -> `rpncareplanreview-content` (Type: layout, Required: 0)
* **rpncareplanreview_loading** -> `rpncareplanreview-loading` (Type: loading, Required: 0)
* **rpncareplanreview_btn_3** -> `rpncareplanreview-btn-3` (Type: button, Required: 0)
* **rpncareplanreview_screen** -> `rpncareplanreview-screen` (Type: layout, Required: 0)
* **rpncareplanreview_btn_1** -> `rpncareplanreview-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `378` (Required: 1)
* Component ID: `912` (Required: 1)
* Component ID: `1446` (Required: 1)
* Component ID: `4894` (Required: 1)
* Component ID: `4895` (Required: 1)
* Component ID: `4896` (Required: 1)
* Component ID: `4897` (Required: 1)
* Component ID: `4898` (Required: 1)
* Component ID: `4899` (Required: 1)
* Component ID: `4900` (Required: 1)
* Component ID: `4901` (Required: 1)
* Component ID: `4902` (Required: 1)
* Component ID: `4903` (Required: 1)

## 7. API / Data Mapping
* API ID: `4743` (Required: 1)
* API ID: `4744` (Required: 1)
* API ID: `4745` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_care_plan_review_runtime`
* **Test Name**: `RpnCarePlanReviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rpn Care Plan Review`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Rpn Care Plan Review`)
4. **click_sidebar_link** (Selector: `None`, Value: `Rpn Care Plan Review`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/rpn-care-plan-review`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
