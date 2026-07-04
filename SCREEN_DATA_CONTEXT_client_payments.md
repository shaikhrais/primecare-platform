# SCREEN DATA CONTEXT: client_payments

Below are the database records from `governance.db` used to configure and build the **Guest - ClientPaymentsScreen** screen.

---

## 1. Screen Record
* **ID**: `664`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `client_payments`
* **Screen Name**: `ClientPaymentsScreen`
* **Route Path**: `/generated/client-payments`
* **Actual File Path**: `apps/primecare_client/lib/features/generated_screens/client_payments_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to client payments.`
* **User Story**: `As a Guest, I want to access the Client Payments within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Client Payments`
* **Acceptance Criteria**:
- The Client Payments route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `client_payments-screen` (Type: layout, Required: 1)
* **page_title** -> `client_payments-title` (Type: header, Required: 1)
* **primary_content** -> `client_payments-content` (Type: layout, Required: 1)
* **clientpaymentsscreen_screen** -> `clientpaymentsscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6648` (Required: 1)
* Component ID: `6649` (Required: 1)
* Component ID: `6650` (Required: 1)
* Component ID: `6651` (Required: 1)
* Component ID: `6652` (Required: 1)

## 7. API / Data Mapping
* API ID: `5024` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `client_payments_runtime`
* **Test Name**: `Client Payments Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Client Payments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/client-payments`)
3. **should_be_visible** (Selector: `client_payments-screen`, Value: `None`)
4. **should_be_visible** (Selector: `client_payments-title`, Value: `None`)
5. **should_be_visible** (Selector: `client_payments-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
