# SCREEN DATA CONTEXT: compliance_reviews

Below are the database records from `governance.db` used to configure and build the **Guest - ComplianceReviewsScreen** screen.

---

## 1. Screen Record
* **ID**: `834`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `compliance_reviews`
* **Screen Name**: `ComplianceReviewsScreen`
* **Route Path**: `/generated/compliance-reviews`
* **Actual File Path**: `apps/primecare_governance/lib/features/qa/screens/compliance_reviews_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to compliance reviews.`
* **User Story**: `As a Guest, I want to access the Compliance Reviews within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Compliance Reviews`
* **Acceptance Criteria**:
- The Compliance Reviews route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_reviews-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_reviews-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_reviews-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7580` (Required: 1)
* Component ID: `7581` (Required: 1)
* Component ID: `7582` (Required: 1)
* Component ID: `7583` (Required: 1)
* Component ID: `7584` (Required: 1)
* Component ID: `7585` (Required: 1)
* Component ID: `7586` (Required: 1)

## 7. API / Data Mapping
* API ID: `5232` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_reviews_runtime`
* **Test Name**: `Compliance Reviews Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Reviews`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/compliance-reviews`)
3. **should_be_visible** (Selector: `compliance_reviews-screen`, Value: `None`)
4. **should_be_visible** (Selector: `compliance_reviews-title`, Value: `None`)
5. **should_be_visible** (Selector: `compliance_reviews-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
