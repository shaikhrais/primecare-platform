# SCREEN DATA CONTEXT: billing

Below are the database records from `governance.db` used to configure and build the **Patient - BillingScreen** screen.

---

## 1. Screen Record
* **ID**: `571`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `billing`
* **Screen Name**: `BillingScreen`
* **Route Path**: `/common/billing`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/billing_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `15`
* **Role Code**: `patient`
* **Role Name**: `Patient`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to billingscreen.`
* **User Story**: `As a Patient, I want to access the BillingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BillingScreen`
* **Acceptance Criteria**:
- The BillingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `billing-screen` (Type: layout, Required: 1)
* **page_title** -> `billing-title` (Type: header, Required: 1)
* **primary_content** -> `billing-content` (Type: layout, Required: 1)
* **billing_btn_1** -> `billing-btn-1` (Type: button, Required: 0)
* **billing_btn_3** -> `billing-btn-3` (Type: button, Required: 0)
* **billing_btn_2** -> `billing-btn-2` (Type: button, Required: 0)
* **billing_loading** -> `billing-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `495` (Required: 1)
* Component ID: `1029` (Required: 1)
* Component ID: `1563` (Required: 1)
* Component ID: `5989` (Required: 1)
* Component ID: `5990` (Required: 1)
* Component ID: `5991` (Required: 1)
* Component ID: `5992` (Required: 1)
* Component ID: `5993` (Required: 1)
* Component ID: `5994` (Required: 1)

## 7. API / Data Mapping
* API ID: `4917` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `billing_runtime`
* **Test Name**: `BillingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `BillingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **visit** (Selector: `None`, Value: `/common/billing`)
3. **should_be_visible** (Selector: `billing-screen`, Value: `None`)
4. **should_be_visible** (Selector: `billing-title`, Value: `None`)
5. **should_be_visible** (Selector: `billing-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
