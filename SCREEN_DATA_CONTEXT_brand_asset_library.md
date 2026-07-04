# SCREEN DATA CONTEXT: brand_asset_library

Below are the database records from `governance.db` used to configure and build the **Guest - BrandAssetLibraryScreen** screen.

---

## 1. Screen Record
* **ID**: `972`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `brand_asset_library`
* **Screen Name**: `BrandAssetLibraryScreen`
* **Route Path**: `/generated/brand-asset-library`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/marketing/brand_asset_library.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to brand asset library.`
* **User Story**: `As a Guest, I want to access the Brand Asset Library within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Brand Asset Library`
* **Acceptance Criteria**:
- The Brand Asset Library route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `brand_asset_library-screen` (Type: layout, Required: 1)
* **page_title** -> `brand_asset_library-title` (Type: header, Required: 1)
* **primary_content** -> `brand_asset_library-content` (Type: layout, Required: 1)
* **brand_asset_library_iconbutton_button_1** -> `brand_asset_library_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8301` (Required: 1)
* Component ID: `8302` (Required: 1)
* Component ID: `8303` (Required: 1)
* Component ID: `8304` (Required: 1)
* Component ID: `8305` (Required: 1)
* Component ID: `8306` (Required: 1)

## 7. API / Data Mapping
* API ID: `5410` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `brand_asset_library_runtime`
* **Test Name**: `Brand Asset Library Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Brand Asset Library`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/brand-asset-library`)
3. **should_be_visible** (Selector: `brand_asset_library-screen`, Value: `None`)
4. **should_be_visible** (Selector: `brand_asset_library-title`, Value: `None`)
5. **should_be_visible** (Selector: `brand_asset_library-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
