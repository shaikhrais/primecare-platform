# SCREEN DATA CONTEXT: rmt_billing_link

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtBillingLinkScreen** screen.

---

## 1. Screen Record
* **ID**: `358`
* **App ID**: `6`
* **Role ID**: `3`
* **Screen Code**: `rmt_billing_link`
* **Screen Name**: `RmtBillingLinkScreen`
* **Route Path**: `/offices/clinical/roles/rmt/billing-link`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_billing_link_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtbillinglinkscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtBillingLinkScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtBillingLinkScreen`
* **Acceptance Criteria**:
- The RmtBillingLinkScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_billing_link-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_billing_link-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_billing_link-content` (Type: layout, Required: 1)
* **rmtbillinglink_screen** -> `rmtbillinglink-screen` (Type: layout, Required: 0)
* **rmtbillinglink_title** -> `rmtbillinglink-title` (Type: header, Required: 0)
* **rmtbillinglink_btn_1** -> `rmtbillinglink-btn-1` (Type: button, Required: 0)
* **rmtbillinglink_btn_3** -> `rmtbillinglink-btn-3` (Type: button, Required: 0)
* **rmtbillinglink_loading** -> `rmtbillinglink-loading` (Type: loading, Required: 0)
* **rmtbillinglink_content** -> `rmtbillinglink-content` (Type: layout, Required: 0)
* **rmtbillinglink_btn_2** -> `rmtbillinglink-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `364` (Required: 1)
* Component ID: `898` (Required: 1)
* Component ID: `1432` (Required: 1)
* Component ID: `4758` (Required: 1)
* Component ID: `4759` (Required: 1)
* Component ID: `4760` (Required: 1)
* Component ID: `4761` (Required: 1)
* Component ID: `4762` (Required: 1)
* Component ID: `4763` (Required: 1)
* Component ID: `4764` (Required: 1)
* Component ID: `4765` (Required: 1)
* Component ID: `4766` (Required: 1)
* Component ID: `4767` (Required: 1)

## 7. API / Data Mapping
* API ID: `4701` (Required: 1)
* API ID: `4702` (Required: 1)
* API ID: `4703` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_billing_link_runtime`
* **Test Name**: `RmtBillingLinkScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Billing Link`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Billing Link`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Billing Link`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/billing-link`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
