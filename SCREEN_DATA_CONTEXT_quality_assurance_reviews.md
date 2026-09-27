# SCREEN DATA CONTEXT: quality_assurance_reviews

Below are the database records from `governance.db` used to configure and build the **Guest - QualityAssuranceReviewsScreen** screen.

---

## 1. Screen Record
* **ID**: `885`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `quality_assurance_reviews`
* **Screen Name**: `QualityAssuranceReviewsScreen`
* **Route Path**: `/generated/quality-assurance-reviews`
* **Actual File Path**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_reviews_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to quality assurance reviews.`
* **User Story**: `As a Guest, I want to access the Quality Assurance Reviews within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Quality Assurance Reviews`
* **Acceptance Criteria**:
- The Quality Assurance Reviews route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `quality_assurance_reviews-screen` (Type: layout, Required: 1)
* **page_title** -> `quality_assurance_reviews-title` (Type: header, Required: 1)
* **primary_content** -> `quality_assurance_reviews-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7870` (Required: 1)
* Component ID: `7871` (Required: 1)
* Component ID: `7872` (Required: 1)
* Component ID: `7873` (Required: 1)
* Component ID: `7874` (Required: 1)
* Component ID: `7875` (Required: 1)
* Component ID: `7876` (Required: 1)

## 7. API / Data Mapping
* API ID: `5299` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `quality_assurance_reviews_runtime`
* **Test Name**: `Quality Assurance Reviews Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Quality Assurance Reviews`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/quality-assurance-reviews`)
3. **should_be_visible** (Selector: `quality_assurance_reviews-screen`, Value: `None`)
4. **should_be_visible** (Selector: `quality_assurance_reviews-title`, Value: `None`)
5. **should_be_visible** (Selector: `quality_assurance_reviews-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
