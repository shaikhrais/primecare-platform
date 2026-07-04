# SCREEN DATA CONTEXT: regional_bdm_deal_tracker

Below are the database records from `governance.db` used to configure and build the **Guest - RegionalBdmDealTrackerScreen** screen.

---

## 1. Screen Record
* **ID**: `622`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `regional_bdm_deal_tracker`
* **Screen Name**: `RegionalBdmDealTrackerScreen`
* **Route Path**: `/offices/business_development/roles/regional_bdm/deal-tracker`
* **Actual File Path**: `apps/primecare_business_development/lib/features/business_development/presentation/widgets/regional_bdm_deal_tracker_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to regional bdm deal tracker.`
* **User Story**: `As a Guest, I want to access the Regional Bdm Deal Tracker within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Regional Bdm Deal Tracker`
* **Acceptance Criteria**:
- The Regional Bdm Deal Tracker route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_bdm_deal_tracker-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_bdm_deal_tracker-title` (Type: header, Required: 1)
* **primary_content** -> `regional_bdm_deal_tracker-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6419` (Required: 1)
* Component ID: `6420` (Required: 1)
* Component ID: `6421` (Required: 1)
* Component ID: `6422` (Required: 1)
* Component ID: `6423` (Required: 1)
* Component ID: `6424` (Required: 1)

## 7. API / Data Mapping
* API ID: `4979` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_bdm_deal_tracker_runtime`
* **Test Name**: `Regional Bdm Deal Tracker Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Regional Bdm Deal Tracker`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/business_development/roles/regional_bdm/deal-tracker`)
3. **should_be_visible** (Selector: `regional_bdm_deal_tracker-screen`, Value: `None`)
4. **should_be_visible** (Selector: `regional_bdm_deal_tracker-title`, Value: `None`)
5. **should_be_visible** (Selector: `regional_bdm_deal_tracker-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
