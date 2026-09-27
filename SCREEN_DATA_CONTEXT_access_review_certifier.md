# SCREEN DATA CONTEXT: access_review_certifier

Below are the database records from `governance.db` used to configure and build the **Guest - AccessReviewCertifierScreen** screen.

---

## 1. Screen Record
* **ID**: `902`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `access_review_certifier`
* **Screen Name**: `AccessReviewCertifierScreen`
* **Route Path**: `/generated/access-review-certifier`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/access_review_certifier.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to access review certifier.`
* **User Story**: `As a Guest, I want to access the Access Review Certifier within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Access Review Certifier`
* **Acceptance Criteria**:
- The Access Review Certifier route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `access_review_certifier-screen` (Type: layout, Required: 1)
* **page_title** -> `access_review_certifier-title` (Type: header, Required: 1)
* **primary_content** -> `access_review_certifier-content` (Type: layout, Required: 1)
* **access_review_certifier_iconbutton_button_1** -> `access_review_certifier_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7965` (Required: 1)
* Component ID: `7966` (Required: 1)
* Component ID: `7967` (Required: 1)
* Component ID: `7968` (Required: 1)

## 7. API / Data Mapping
* API ID: `5316` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `access_review_certifier_runtime`
* **Test Name**: `Access Review Certifier Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Access Review Certifier`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/access-review-certifier`)
3. **should_be_visible** (Selector: `access_review_certifier-screen`, Value: `None`)
4. **should_be_visible** (Selector: `access_review_certifier-title`, Value: `None`)
5. **should_be_visible** (Selector: `access_review_certifier-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
