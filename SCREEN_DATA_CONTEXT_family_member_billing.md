# SCREEN DATA CONTEXT: family_member_billing

Below are the database records from `governance.db` used to configure and build the **Guest - FamilyMemberBillingScreen** screen.

---

## 1. Screen Record
* **ID**: `667`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `family_member_billing`
* **Screen Name**: `FamilyMemberBillingScreen`
* **Route Path**: `/generated/family-member-billing`
* **Actual File Path**: `apps/primecare_client/lib/features/generated_screens/family_member_billing_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to family member billing.`
* **User Story**: `As a Guest, I want to access the Family Member Billing within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Family Member Billing`
* **Acceptance Criteria**:
- The Family Member Billing route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `family_member_billing-screen` (Type: layout, Required: 1)
* **page_title** -> `family_member_billing-title` (Type: header, Required: 1)
* **primary_content** -> `family_member_billing-content` (Type: layout, Required: 1)
* **familymemberbillingscreen_screen** -> `familymemberbillingscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6663` (Required: 1)
* Component ID: `6664` (Required: 1)
* Component ID: `6665` (Required: 1)
* Component ID: `6666` (Required: 1)
* Component ID: `6667` (Required: 1)

## 7. API / Data Mapping
* API ID: `5027` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `family_member_billing_runtime`
* **Test Name**: `Family Member Billing Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Family Member Billing`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Family Member Billing`)
4. **click_sidebar_link** (Selector: `None`, Value: `Family Member Billing`)
5. **check_url** (Selector: `None`, Value: `/generated/family-member-billing`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
