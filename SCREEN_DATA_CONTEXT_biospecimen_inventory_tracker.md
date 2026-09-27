# SCREEN DATA CONTEXT: biospecimen_inventory_tracker

Below are the database records from `governance.db` used to configure and build the **Guest - BiospecimenInventoryTrackerScreen** screen.

---

## 1. Screen Record
* **ID**: `1009`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `biospecimen_inventory_tracker`
* **Screen Name**: `BiospecimenInventoryTrackerScreen`
* **Route Path**: `/generated/biospecimen-inventory-tracker`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/research/biospecimen_inventory_tracker.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to biospecimen inventory tracker.`
* **User Story**: `As a Guest, I want to access the Biospecimen Inventory Tracker within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Biospecimen Inventory Tracker`
* **Acceptance Criteria**:
- The Biospecimen Inventory Tracker route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `biospecimen_inventory_tracker-screen` (Type: layout, Required: 1)
* **page_title** -> `biospecimen_inventory_tracker-title` (Type: header, Required: 1)
* **primary_content** -> `biospecimen_inventory_tracker-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8533` (Required: 1)
* Component ID: `8534` (Required: 1)
* Component ID: `8535` (Required: 1)
* Component ID: `8536` (Required: 1)
* Component ID: `8537` (Required: 1)
* Component ID: `8538` (Required: 1)

## 7. API / Data Mapping
* API ID: `5473` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `biospecimen_inventory_tracker_runtime`
* **Test Name**: `Biospecimen Inventory Tracker Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Biospecimen Inventory Tracker`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/biospecimen-inventory-tracker`)
3. **should_be_visible** (Selector: `biospecimen_inventory_tracker-screen`, Value: `None`)
4. **should_be_visible** (Selector: `biospecimen_inventory_tracker-title`, Value: `None`)
5. **should_be_visible** (Selector: `biospecimen_inventory_tracker-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
