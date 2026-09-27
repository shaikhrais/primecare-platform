# SCREEN DATA CONTEXT: billing_payments

Below are the database records from `governance.db` used to configure and build the **Guest - BillingPaymentsScreen** screen.

---

## 1. Screen Record
* **ID**: `963`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `billing_payments`
* **Screen Name**: `BillingPaymentsScreen`
* **Route Path**: `/generated/billing-payments`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/billing_payments_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to billing payments.`
* **User Story**: `As a Guest, I want to access the Billing Payments within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Billing Payments`
* **Acceptance Criteria**:
- The Billing Payments route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `billing_payments-screen` (Type: layout, Required: 1)
* **page_title** -> `billing_payments-title` (Type: header, Required: 1)
* **primary_content** -> `billing_payments-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8248` (Required: 1)
* Component ID: `8249` (Required: 1)
* Component ID: `8250` (Required: 1)
* Component ID: `8251` (Required: 1)
* Component ID: `8252` (Required: 1)
* Component ID: `8253` (Required: 1)

## 7. API / Data Mapping
* API ID: `5401` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `billing_payments_runtime`
* **Test Name**: `Billing Payments Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Billing Payments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/billing-payments`)
3. **should_be_visible** (Selector: `billing_payments-screen`, Value: `None`)
4. **should_be_visible** (Selector: `billing_payments-title`, Value: `None`)
5. **should_be_visible** (Selector: `billing_payments-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
