# SCREEN DATA CONTEXT: audit_review

Below are the database records from `governance.db` used to configure and build the **Compliance Manager - AuditReviewScreen** screen.

---

## 1. Screen Record
* **ID**: `486`
* **App ID**: `5`
* **Role ID**: `33`
* **Screen Code**: `audit_review`
* **Screen Name**: `AuditReviewScreen`
* **Route Path**: `/management/audit-review`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/audit_review_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `33`
* **Role Code**: `compliance`
* **Role Name**: `Compliance Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Compliance Manager personnel to oversee, audit, and coordinate operations related to auditreviewscreen.`
* **User Story**: `As a Compliance Manager, I want to access the AuditReviewScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `AuditReviewScreen`
* **Acceptance Criteria**:
- The AuditReviewScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Compliance Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `audit_review-screen` (Type: layout, Required: 1)
* **page_title** -> `audit_review-title` (Type: header, Required: 1)
* **primary_content** -> `audit_review-content` (Type: layout, Required: 1)
* **auditreview_btn_3** -> `auditreview-btn-3` (Type: button, Required: 0)
* **auditreview_loading** -> `auditreview-loading` (Type: loading, Required: 0)
* **auditreview_btn_2** -> `auditreview-btn-2` (Type: button, Required: 0)
* **auditreview_btn_1** -> `auditreview-btn-1` (Type: button, Required: 0)
* **auditreview_content** -> `auditreview-content` (Type: layout, Required: 0)
* **auditreview_title** -> `auditreview-title` (Type: header, Required: 0)
* **auditreview_screen** -> `auditreview-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `415` (Required: 1)
* Component ID: `949` (Required: 1)
* Component ID: `1483` (Required: 1)
* Component ID: `5244` (Required: 1)
* Component ID: `5245` (Required: 1)
* Component ID: `5246` (Required: 1)
* Component ID: `5247` (Required: 1)
* Component ID: `5248` (Required: 1)
* Component ID: `5249` (Required: 1)
* Component ID: `5250` (Required: 1)
* Component ID: `5251` (Required: 1)
* Component ID: `5252` (Required: 1)
* Component ID: `5253` (Required: 1)

## 7. API / Data Mapping
* API ID: `4803` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `audit_review_runtime`
* **Test Name**: `AuditReviewScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `AuditReviewScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **visit** (Selector: `None`, Value: `/management/audit-review`)
3. **should_be_visible** (Selector: `audit_review-screen`, Value: `None`)
4. **should_be_visible** (Selector: `audit_review-title`, Value: `None`)
5. **should_be_visible** (Selector: `audit_review-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
