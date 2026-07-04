# SCREEN DATA CONTEXT: cfo_financial_overview

Below are the database records from `governance.db` used to configure and build the **Guest - CfoFinancialOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `717`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cfo_financial_overview`
* **Screen Name**: `CfoFinancialOverviewScreen`
* **Route Path**: `/offices/corporate/roles/cfo/financial-overview`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cfo_financial_overview_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cfo financial overview.`
* **User Story**: `As a Guest, I want to access the Cfo Financial Overview within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cfo Financial Overview`
* **Acceptance Criteria**:
- The Cfo Financial Overview route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_financial_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_financial_overview-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_financial_overview-content` (Type: layout, Required: 1)
* **cfofinancialoverviewscreen_screen** -> `cfofinancialoverviewscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6935` (Required: 1)
* Component ID: `6936` (Required: 1)
* Component ID: `6937` (Required: 1)
* Component ID: `6938` (Required: 1)
* Component ID: `6939` (Required: 1)

## 7. API / Data Mapping
* API ID: `5095` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_financial_overview_runtime`
* **Test Name**: `Cfo Financial Overview Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cfo Financial Overview`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cfo/financial-overview`)
3. **should_be_visible** (Selector: `cfo_financial_overview-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_financial_overview-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_financial_overview-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
