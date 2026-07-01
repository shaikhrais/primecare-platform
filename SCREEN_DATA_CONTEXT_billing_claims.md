# SCREEN DATA CONTEXT: billing_claims

Below are the database records from `governance.db` used to configure and build the **Guest - BillingClaimsScreen** screen.

---

## 1. Screen Record
* **ID**: `961`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `billing_claims`
* **Screen Name**: `BillingClaimsScreen`
* **Route Path**: `/generated/billing-claims`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/billing_claims_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to billing claims.`
* **User Story**: `As a Guest, I want to access the Billing Claims within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Billing Claims`
* **Acceptance Criteria**:
- The Billing Claims route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `billing_claims-screen` (Type: layout, Required: 1)
* **page_title** -> `billing_claims-title` (Type: header, Required: 1)
* **primary_content** -> `billing_claims-content` (Type: layout, Required: 1)
* **billing_claims_screen_outlinedbutton_button_1** -> `billing_claims_screen_outlinedbutton_button_1` (Type: button, Required: 0)
* **billing_claims_screen_iconbutton_button_1** -> `billing_claims_screen_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8239` (Required: 1)
* Component ID: `8240` (Required: 1)
* Component ID: `8241` (Required: 1)
* Component ID: `8242` (Required: 1)
* Component ID: `8243` (Required: 1)

## 7. API / Data Mapping
* API ID: `5399` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `billing_claims_runtime`
* **Test Name**: `Billing Claims Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Billing Claims`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Billing Claims`)
4. **click_sidebar_link** (Selector: `None`, Value: `Billing Claims`)
5. **check_url** (Selector: `None`, Value: `/generated/billing-claims`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
