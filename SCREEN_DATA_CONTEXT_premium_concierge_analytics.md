# SCREEN DATA CONTEXT: premium_concierge_analytics

Below are the database records from `governance.db` used to configure and build the **Premium Concierge Care Coordinator - PremiumConciergeCareCoordinatorAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `607`
* **App ID**: `1`
* **Role ID**: `49`
* **Screen Code**: `premium_concierge_analytics`
* **Screen Name**: `PremiumConciergeCareCoordinatorAnalyticsScreen`
* **Route Path**: `/premium/premium-concierge-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/premium/premium_concierge_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `49`
* **Role Code**: `premium_concierge`
* **Role Name**: `Premium Concierge Care Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Premium Concierge Care Coordinator personnel to oversee, audit, and coordinate operations related to premium concierge care coordinator analytics.`
* **User Story**: `As a Premium Concierge Care Coordinator, I want to access the Premium Concierge Care Coordinator Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Premium Concierge Care Coordinator Analytics`
* **Acceptance Criteria**:
- The Premium Concierge Care Coordinator Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Premium Concierge Care Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `premium_concierge_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `premium_concierge_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `premium_concierge_analytics-content` (Type: layout, Required: 1)
* **premium concierge care coordinator analytics_title** -> `premium concierge care coordinator analytics-title` (Type: header, Required: 0)
* **premium concierge care coordinator analytics_screen** -> `premium concierge care coordinator analytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `531` (Required: 1)
* Component ID: `1065` (Required: 1)
* Component ID: `1599` (Required: 1)
* Component ID: `6307` (Required: 1)
* Component ID: `6308` (Required: 1)
* Component ID: `6309` (Required: 1)
* Component ID: `6310` (Required: 1)

## 7. API / Data Mapping
* API ID: `4956` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `premium_concierge_analytics_runtime`
* **Test Name**: `Premium Concierge Care Coordinator Analytics Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Premium Concierge Care Coordinator Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `premium_concierge`)
2. **visit** (Selector: `None`, Value: `/premium/premium-concierge-analytics`)
3. **should_be_visible** (Selector: `premium_concierge_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `premium_concierge_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `premium_concierge_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
