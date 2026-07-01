# SCREEN DATA CONTEXT: compliance_review

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ComplianceReviewScreen** screen.

---

## 1. Screen Record
* **ID**: `555`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `compliance_review`
* **Screen Name**: `ComplianceReviewScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/compliance-review`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/compliance_review_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to compliancereviewscreen.`
* **User Story**: `As a Clinical Director, I want to access the ComplianceReviewScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ComplianceReviewScreen`
* **Acceptance Criteria**:
- The ComplianceReviewScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_review-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_review-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_review-content` (Type: layout, Required: 1)
* **compliancereview_btn_2** -> `compliancereview-btn-2` (Type: button, Required: 0)
* **compliancereview_screen** -> `compliancereview-screen` (Type: layout, Required: 0)
* **compliancereview_loading** -> `compliancereview-loading` (Type: loading, Required: 0)
* **compliancereview_btn_3** -> `compliancereview-btn-3` (Type: button, Required: 0)
* **compliancereview_content** -> `compliancereview-content` (Type: layout, Required: 0)
* **compliancereview_title** -> `compliancereview-title` (Type: header, Required: 0)
* **compliancereview_btn_1** -> `compliancereview-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `479` (Required: 1)
* Component ID: `1013` (Required: 1)
* Component ID: `1547` (Required: 1)
* Component ID: `5853` (Required: 1)
* Component ID: `5854` (Required: 1)
* Component ID: `5855` (Required: 1)
* Component ID: `5856` (Required: 1)
* Component ID: `5857` (Required: 1)
* Component ID: `5858` (Required: 1)
* Component ID: `5859` (Required: 1)
* Component ID: `5860` (Required: 1)
* Component ID: `5861` (Required: 1)

## 7. API / Data Mapping
* API ID: `4902` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_review_runtime`
* **Test Name**: `ComplianceReviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Review`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Compliance Review`)
4. **click_sidebar_link** (Selector: `None`, Value: `Compliance Review`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/compliance-review`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
