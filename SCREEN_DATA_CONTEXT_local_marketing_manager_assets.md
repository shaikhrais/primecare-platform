# SCREEN DATA CONTEXT: local_marketing_manager_assets

Below are the database records from `governance.db` used to configure and build the **Guest - LocalMarketingManagerAssetsScreen** screen.

---

## 1. Screen Record
* **ID**: `855`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `local_marketing_manager_assets`
* **Screen Name**: `LocalMarketingManagerAssetsScreen`
* **Route Path**: `/generated/local-marketing-manager-assets`
* **Actual File Path**: `apps/primecare_marketing/lib/features/generated_screens/local_marketing_manager_assets_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to local marketing manager assets.`
* **User Story**: `As a Guest, I want to access the Local Marketing Manager Assets within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Local Marketing Manager Assets`
* **Acceptance Criteria**:
- The Local Marketing Manager Assets route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `local_marketing_manager_assets-screen` (Type: layout, Required: 1)
* **page_title** -> `local_marketing_manager_assets-title` (Type: header, Required: 1)
* **primary_content** -> `local_marketing_manager_assets-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7701` (Required: 1)
* Component ID: `7702` (Required: 1)
* Component ID: `7703` (Required: 1)
* Component ID: `7704` (Required: 1)
* Component ID: `7705` (Required: 1)

## 7. API / Data Mapping
* API ID: `5255` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `local_marketing_manager_assets_runtime`
* **Test Name**: `Local Marketing Manager Assets Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Local Marketing Manager Assets`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/local-marketing-manager-assets`)
3. **should_be_visible** (Selector: `local_marketing_manager_assets-screen`, Value: `None`)
4. **should_be_visible** (Selector: `local_marketing_manager_assets-title`, Value: `None`)
5. **should_be_visible** (Selector: `local_marketing_manager_assets-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
