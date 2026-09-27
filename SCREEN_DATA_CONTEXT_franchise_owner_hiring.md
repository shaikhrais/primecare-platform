# SCREEN DATA CONTEXT: franchise_owner_hiring

Below are the database records from `governance.db` used to configure and build the **Guest - FranchiseOwnerHiringScreen** screen.

---

## 1. Screen Record
* **ID**: `795`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `franchise_owner_hiring`
* **Screen Name**: `FranchiseOwnerHiringScreen`
* **Route Path**: `/offices/franchise/roles/franchise_owner/hiring`
* **Actual File Path**: `apps/primecare_franchise/lib/features/owner/screens/franchise_owner_hiring_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to franchise owner hiring.`
* **User Story**: `As a Guest, I want to access the Franchise Owner Hiring within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Franchise Owner Hiring`
* **Acceptance Criteria**:
- The Franchise Owner Hiring route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_hiring-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_hiring-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_hiring-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7354` (Required: 1)
* Component ID: `7355` (Required: 1)
* Component ID: `7356` (Required: 1)
* Component ID: `7357` (Required: 1)
* Component ID: `7358` (Required: 1)

## 7. API / Data Mapping
* API ID: `5183` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_hiring_runtime`
* **Test Name**: `Franchise Owner Hiring Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Owner Hiring`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/franchise_owner/hiring`)
3. **should_be_visible** (Selector: `franchise_owner_hiring-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_owner_hiring-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_owner_hiring-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
