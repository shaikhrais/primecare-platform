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
* **Stage/Status**: `template_created`

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
* **Test Name**: `ComplianceReviewScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ComplianceReviewScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/compliance-review`)
3. **should_be_visible** (Selector: `compliance_review-screen`, Value: `None`)
4. **should_be_visible** (Selector: `compliance_review-title`, Value: `None`)
5. **should_be_visible** (Selector: `compliance_review-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
