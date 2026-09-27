# SCREEN DATA CONTEXT: brand_management

Below are the database records from `governance.db` used to configure and build the **Head of Marketing - BrandManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `502`
* **App ID**: `11`
* **Role ID**: `38`
* **Screen Code**: `brand_management`
* **Screen Name**: `BrandManagementScreen`
* **Route Path**: `/management/brand-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/brand_management_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `11`
* **App Code**: `ma`
* **App Name**: `Primecare Marketing`

## 3. Role Record
* **ID**: `38`
* **Role Code**: `marketing`
* **Role Name**: `Head of Marketing`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Marketing module to enable Head of Marketing personnel to oversee, audit, and coordinate operations related to brandmanagementscreen.`
* **User Story**: `As a Head of Marketing, I want to access the BrandManagementScreen within the Primecare Marketing application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BrandManagementScreen`
* **Acceptance Criteria**:
- The BrandManagementScreen route loads successfully within the Primecare Marketing workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Marketing access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `brand_management-screen` (Type: layout, Required: 1)
* **page_title** -> `brand_management-title` (Type: header, Required: 1)
* **primary_content** -> `brand_management-content` (Type: layout, Required: 1)
* **brandmanagement_btn_3** -> `brandmanagement-btn-3` (Type: button, Required: 0)
* **brandmanagement_btn_1** -> `brandmanagement-btn-1` (Type: button, Required: 0)
* **brandmanagement_screen** -> `brandmanagement-screen` (Type: layout, Required: 0)
* **brandmanagement_loading** -> `brandmanagement-loading` (Type: loading, Required: 0)
* **brandmanagement_content** -> `brandmanagement-content` (Type: layout, Required: 0)
* **brandmanagement_title** -> `brandmanagement-title` (Type: header, Required: 0)
* **brandmanagement_btn_2** -> `brandmanagement-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `431` (Required: 1)
* Component ID: `965` (Required: 1)
* Component ID: `1499` (Required: 1)
* Component ID: `5401` (Required: 1)
* Component ID: `5402` (Required: 1)
* Component ID: `5403` (Required: 1)
* Component ID: `5404` (Required: 1)
* Component ID: `5405` (Required: 1)
* Component ID: `5406` (Required: 1)
* Component ID: `5407` (Required: 1)
* Component ID: `5408` (Required: 1)
* Component ID: `5409` (Required: 1)
* Component ID: `5410` (Required: 1)

## 7. API / Data Mapping
* API ID: `4819` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `brand_management_runtime`
* **Test Name**: `BrandManagementScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `BrandManagementScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `marketing`)
2. **visit** (Selector: `None`, Value: `/management/brand-management`)
3. **should_be_visible** (Selector: `brand_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `brand_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `brand_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
