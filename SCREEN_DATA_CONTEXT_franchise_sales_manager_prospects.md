# SCREEN DATA CONTEXT: franchise_sales_manager_prospects

Below are the database records from `governance.db` used to configure and build the **Guest - FranchiseSalesManagerProspectsScreen** screen.

---

## 1. Screen Record
* **ID**: `635`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `franchise_sales_manager_prospects`
* **Screen Name**: `FranchiseSalesManagerProspectsScreen`
* **Route Path**: `/offices/business_development/roles/franchise_sales_manager/prospects`
* **Actual File Path**: `apps/primecare_franchise/lib/features/generated_screens/franchise_sales_manager_prospects_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to franchise sales manager prospects.`
* **User Story**: `As a Guest, I want to access the Franchise Sales Manager Prospects within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Franchise Sales Manager Prospects`
* **Acceptance Criteria**:
- The Franchise Sales Manager Prospects route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_sales_manager_prospects-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_sales_manager_prospects-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_sales_manager_prospects-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6496` (Required: 1)
* Component ID: `6497` (Required: 1)
* Component ID: `6498` (Required: 1)
* Component ID: `6499` (Required: 1)
* Component ID: `6500` (Required: 1)

## 7. API / Data Mapping
* API ID: `4992` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_sales_manager_prospects_runtime`
* **Test Name**: `Franchise Sales Manager Prospects Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Sales Manager Prospects`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/business_development/roles/franchise_sales_manager/prospects`)
3. **should_be_visible** (Selector: `franchise_sales_manager_prospects-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_sales_manager_prospects-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_sales_manager_prospects-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
