# SCREEN DATA CONTEXT: family_billing

Below are the database records from `governance.db` used to configure and build the **Guest - FamilyBillingScreen** screen.

---

## 1. Screen Record
* **ID**: `654`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `family_billing`
* **Screen Name**: `FamilyBillingScreen`
* **Route Path**: `/offices/client/roles/family_member/billing`
* **Actual File Path**: `apps/primecare_client/lib/features/family/screens/family_billing_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to family billing.`
* **User Story**: `As a Guest, I want to access the Family Billing within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Family Billing`
* **Acceptance Criteria**:
- The Family Billing route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `family_billing-screen` (Type: layout, Required: 1)
* **page_title** -> `family_billing-title` (Type: header, Required: 1)
* **primary_content** -> `family_billing-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6599` (Required: 1)
* Component ID: `6600` (Required: 1)
* Component ID: `6601` (Required: 1)
* Component ID: `6602` (Required: 1)
* Component ID: `6603` (Required: 1)

## 7. API / Data Mapping
* API ID: `5013` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `family_billing_runtime`
* **Test Name**: `Family Billing Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Family Billing`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/client/roles/family_member/billing`)
3. **should_be_visible** (Selector: `family_billing-screen`, Value: `None`)
4. **should_be_visible** (Selector: `family_billing-title`, Value: `None`)
5. **should_be_visible** (Selector: `family_billing-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
