# SCREEN DATA CONTEXT: cto_platform_usage

Below are the database records from `governance.db` used to configure and build the **Guest - CtoPlatformUsageScreen** screen.

---

## 1. Screen Record
* **ID**: `753`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cto_platform_usage`
* **Screen Name**: `CtoPlatformUsageScreen`
* **Route Path**: `/offices/corporate/roles/cto/platform-usage`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cto_platform_usage_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cto platform usage.`
* **User Story**: `As a Guest, I want to access the Cto Platform Usage within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cto Platform Usage`
* **Acceptance Criteria**:
- The Cto Platform Usage route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_platform_usage-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_platform_usage-title` (Type: header, Required: 1)
* **primary_content** -> `cto_platform_usage-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7134` (Required: 1)
* Component ID: `7135` (Required: 1)
* Component ID: `7136` (Required: 1)
* Component ID: `7137` (Required: 1)
* Component ID: `7138` (Required: 1)
* Component ID: `7139` (Required: 1)

## 7. API / Data Mapping
* API ID: `5141` (Required: 1)
* API ID: `5142` (Required: 1)
* API ID: `5143` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_platform_usage_runtime`
* **Test Name**: `Cto Platform Usage Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cto Platform Usage`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cto/platform-usage`)
3. **should_be_visible** (Selector: `cto_platform_usage-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cto_platform_usage-title`, Value: `None`)
5. **should_be_visible** (Selector: `cto_platform_usage-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
