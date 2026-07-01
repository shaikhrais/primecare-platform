# SCREEN DATA CONTEXT: physiotherapist_billing_link

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistBillingLinkScreen** screen.

---

## 1. Screen Record
* **ID**: `341`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_billing_link`
* **Screen Name**: `PhysiotherapistBillingLinkScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/billing-link`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_billing_link_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistbillinglinkscreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistBillingLinkScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistBillingLinkScreen`
* **Acceptance Criteria**:
- The PhysiotherapistBillingLinkScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_billing_link-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_billing_link-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_billing_link-content` (Type: layout, Required: 1)
* **physiotherapistbillinglink_btn_2** -> `physiotherapistbillinglink-btn-2` (Type: button, Required: 0)
* **physiotherapistbillinglink_btn_3** -> `physiotherapistbillinglink-btn-3` (Type: button, Required: 0)
* **physiotherapistbillinglink_content** -> `physiotherapistbillinglink-content` (Type: layout, Required: 0)
* **physiotherapistbillinglink_title** -> `physiotherapistbillinglink-title` (Type: header, Required: 0)
* **physiotherapistbillinglink_btn_1** -> `physiotherapistbillinglink-btn-1` (Type: button, Required: 0)
* **physiotherapistbillinglink_screen** -> `physiotherapistbillinglink-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `349` (Required: 1)
* Component ID: `883` (Required: 1)
* Component ID: `1417` (Required: 1)
* Component ID: `4609` (Required: 1)
* Component ID: `4610` (Required: 1)
* Component ID: `4611` (Required: 1)
* Component ID: `4612` (Required: 1)
* Component ID: `4613` (Required: 1)
* Component ID: `4614` (Required: 1)
* Component ID: `4615` (Required: 1)
* Component ID: `4616` (Required: 1)

## 7. API / Data Mapping
* API ID: `4674` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_billing_link_runtime`
* **Test Name**: `PhysiotherapistBillingLinkScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Physiotherapist Billing Link`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Physiotherapist Billing Link`)
4. **click_sidebar_link** (Selector: `None`, Value: `Physiotherapist Billing Link`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/billing-link`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
