# SCREEN DATA CONTEXT: territory_sales_manager_competitors

Below are the database records from `governance.db` used to configure and build the **Guest - TerritorySalesManagerCompetitorsScreen** screen.

---

## 1. Screen Record
* **ID**: `863`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `territory_sales_manager_competitors`
* **Screen Name**: `TerritorySalesManagerCompetitorsScreen`
* **Route Path**: `/generated/territory-sales-manager-competitors`
* **Actual File Path**: `apps/primecare_marketing/lib/features/generated_screens/territory_sales_manager_competitors_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to territory sales manager competitors.`
* **User Story**: `As a Guest, I want to access the Territory Sales Manager Competitors within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Territory Sales Manager Competitors`
* **Acceptance Criteria**:
- The Territory Sales Manager Competitors route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `territory_sales_manager_competitors-screen` (Type: layout, Required: 1)
* **page_title** -> `territory_sales_manager_competitors-title` (Type: header, Required: 1)
* **primary_content** -> `territory_sales_manager_competitors-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7745` (Required: 1)
* Component ID: `7746` (Required: 1)
* Component ID: `7747` (Required: 1)
* Component ID: `7748` (Required: 1)
* Component ID: `7749` (Required: 1)

## 7. API / Data Mapping
* API ID: `5265` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `territory_sales_manager_competitors_runtime`
* **Test Name**: `Territory Sales Manager Competitors Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Territory Sales Manager Competitors`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/territory-sales-manager-competitors`)
3. **should_be_visible** (Selector: `territory_sales_manager_competitors-screen`, Value: `None`)
4. **should_be_visible** (Selector: `territory_sales_manager_competitors-title`, Value: `None`)
5. **should_be_visible** (Selector: `territory_sales_manager_competitors-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
