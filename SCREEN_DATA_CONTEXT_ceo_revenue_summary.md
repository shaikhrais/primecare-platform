# SCREEN DATA CONTEXT: ceo_revenue_summary

Below are the database records from `governance.db` used to configure and build the **Guest - CeoRevenueSummaryScreen** screen.

---

## 1. Screen Record
* **ID**: `713`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `ceo_revenue_summary`
* **Screen Name**: `CeoRevenueSummaryScreen`
* **Route Path**: `/offices/corporate/roles/ceo/revenue-summary`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/ceo_revenue_summary_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to ceo revenue summary.`
* **User Story**: `As a Guest, I want to access the Ceo Revenue Summary within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Ceo Revenue Summary`
* **Acceptance Criteria**:
- The Ceo Revenue Summary route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ceo_revenue_summary-screen` (Type: layout, Required: 1)
* **page_title** -> `ceo_revenue_summary-title` (Type: header, Required: 1)
* **primary_content** -> `ceo_revenue_summary-content` (Type: layout, Required: 1)
* **ceorevenuesummaryscreen_screen** -> `ceorevenuesummaryscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6913` (Required: 1)
* Component ID: `6914` (Required: 1)
* Component ID: `6915` (Required: 1)
* Component ID: `6916` (Required: 1)

## 7. API / Data Mapping
* API ID: `5091` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ceo_revenue_summary_runtime`
* **Test Name**: `Ceo Revenue Summary Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Ceo Revenue Summary`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/ceo/revenue-summary`)
3. **should_be_visible** (Selector: `ceo_revenue_summary-screen`, Value: `None`)
4. **should_be_visible** (Selector: `ceo_revenue_summary-title`, Value: `None`)
5. **should_be_visible** (Selector: `ceo_revenue_summary-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
