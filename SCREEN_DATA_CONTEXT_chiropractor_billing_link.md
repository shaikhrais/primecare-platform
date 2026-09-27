# SCREEN DATA CONTEXT: chiropractor_billing_link

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorBillingLinkScreen** screen.

---

## 1. Screen Record
* **ID**: `296`
* **App ID**: `6`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_billing_link`
* **Screen Name**: `ChiropractorBillingLinkScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/billing-link`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_billing_link_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorbillinglinkscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorBillingLinkScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorBillingLinkScreen`
* **Acceptance Criteria**:
- The ChiropractorBillingLinkScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_billing_link-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_billing_link-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_billing_link-content` (Type: layout, Required: 1)
* **chiropractorbillinglink_btn_1** -> `chiropractorbillinglink-btn-1` (Type: button, Required: 0)
* **chiropractorbillinglink_title** -> `chiropractorbillinglink-title` (Type: header, Required: 0)
* **chiropractorbillinglink_btn_3** -> `chiropractorbillinglink-btn-3` (Type: button, Required: 0)
* **chiropractorbillinglink_screen** -> `chiropractorbillinglink-screen` (Type: layout, Required: 0)
* **chiropractorbillinglink_btn_2** -> `chiropractorbillinglink-btn-2` (Type: button, Required: 0)
* **chiropractorbillinglink_content** -> `chiropractorbillinglink-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `304` (Required: 1)
* Component ID: `838` (Required: 1)
* Component ID: `1372` (Required: 1)
* Component ID: `4234` (Required: 1)
* Component ID: `4235` (Required: 1)
* Component ID: `4236` (Required: 1)
* Component ID: `4237` (Required: 1)
* Component ID: `4238` (Required: 1)
* Component ID: `4239` (Required: 1)
* Component ID: `4240` (Required: 1)
* Component ID: `4241` (Required: 1)

## 7. API / Data Mapping
* API ID: `4623` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_billing_link_runtime`
* **Test Name**: `ChiropractorBillingLinkScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ChiropractorBillingLinkScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/billing-link`)
3. **should_be_visible** (Selector: `chiropractor_billing_link-screen`, Value: `None`)
4. **should_be_visible** (Selector: `chiropractor_billing_link-title`, Value: `None`)
5. **should_be_visible** (Selector: `chiropractor_billing_link-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
