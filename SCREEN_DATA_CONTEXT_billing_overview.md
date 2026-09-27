# SCREEN DATA CONTEXT: billing_overview

Below are the database records from `governance.db` used to configure and build the **Family Member - BillingOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `575`
* **App ID**: `5`
* **Role ID**: `64`
* **Screen Code**: `billing_overview`
* **Screen Name**: `BillingOverviewScreen`
* **Route Path**: `/common/billing-overview`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/billing_overview_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `64`
* **Role Code**: `family`
* **Role Name**: `Family Member`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Family Member personnel to oversee, audit, and coordinate operations related to billingoverviewscreen.`
* **User Story**: `As a Family Member, I want to access the BillingOverviewScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BillingOverviewScreen`
* **Acceptance Criteria**:
- The BillingOverviewScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Family Member access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `billing_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `billing_overview-title` (Type: header, Required: 1)
* **primary_content** -> `billing_overview-content` (Type: layout, Required: 1)
* **billingoverview_content** -> `billingoverview-content` (Type: layout, Required: 0)
* **billingoverview_btn_1** -> `billingoverview-btn-1` (Type: button, Required: 0)
* **billingoverview_screen** -> `billingoverview-screen` (Type: layout, Required: 0)
* **billingoverview_loading** -> `billingoverview-loading` (Type: loading, Required: 0)
* **billingoverview_btn_3** -> `billingoverview-btn-3` (Type: button, Required: 0)
* **billingoverview_title** -> `billingoverview-title` (Type: header, Required: 0)
* **billingoverview_btn_2** -> `billingoverview-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `499` (Required: 1)
* Component ID: `1033` (Required: 1)
* Component ID: `1567` (Required: 1)
* Component ID: `6012` (Required: 1)
* Component ID: `6013` (Required: 1)
* Component ID: `6014` (Required: 1)
* Component ID: `6015` (Required: 1)

## 7. API / Data Mapping
* API ID: `4917` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `billing_overview_runtime`
* **Test Name**: `BillingOverviewScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `BillingOverviewScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `family`)
2. **visit** (Selector: `None`, Value: `/common/billing-overview`)
3. **should_be_visible** (Selector: `billing_overview-screen`, Value: `None`)
4. **should_be_visible** (Selector: `billing_overview-title`, Value: `None`)
5. **should_be_visible** (Selector: `billing_overview-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
