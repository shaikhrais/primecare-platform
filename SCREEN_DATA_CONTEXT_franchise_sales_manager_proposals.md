# SCREEN DATA CONTEXT: franchise_sales_manager_proposals

Below are the database records from `governance.db` used to configure and build the **Guest - FranchiseSalesManagerProposalsScreen** screen.

---

## 1. Screen Record
* **ID**: `634`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `franchise_sales_manager_proposals`
* **Screen Name**: `FranchiseSalesManagerProposalsScreen`
* **Route Path**: `/offices/business_development/roles/franchise_sales_manager/proposals`
* **Actual File Path**: `apps/primecare_franchise/lib/features/generated_screens/franchise_sales_manager_proposals_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to franchise sales manager proposals.`
* **User Story**: `As a Guest, I want to access the Franchise Sales Manager Proposals within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Franchise Sales Manager Proposals`
* **Acceptance Criteria**:
- The Franchise Sales Manager Proposals route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_sales_manager_proposals-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_sales_manager_proposals-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_sales_manager_proposals-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6489` (Required: 1)
* Component ID: `6490` (Required: 1)
* Component ID: `6491` (Required: 1)
* Component ID: `6492` (Required: 1)
* Component ID: `6493` (Required: 1)
* Component ID: `6494` (Required: 1)
* Component ID: `6495` (Required: 1)

## 7. API / Data Mapping
* API ID: `4991` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_sales_manager_proposals_runtime`
* **Test Name**: `Franchise Sales Manager Proposals Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Sales Manager Proposals`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Sales Manager Proposals`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Sales Manager Proposals`)
5. **check_url** (Selector: `None`, Value: `/offices/business_development/roles/franchise_sales_manager/proposals`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
