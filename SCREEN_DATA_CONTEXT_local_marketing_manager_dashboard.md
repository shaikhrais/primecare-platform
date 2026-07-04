# SCREEN DATA CONTEXT: local_marketing_manager_dashboard

Below are the database records from `governance.db` used to configure and build the **Local Marketing Manager - LocalMarketingManagerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `51`
* **App ID**: `11`
* **Role ID**: `39`
* **Screen Code**: `local_marketing_manager_dashboard`
* **Screen Name**: `LocalMarketingManagerDashboardScreen`
* **Route Path**: `/offices/marketing/roles/local_marketing_manager/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/local_marketing_manager_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `11`
* **App Code**: `ma`
* **App Name**: `Primecare Marketing`

## 3. Role Record
* **ID**: `39`
* **Role Code**: `local_marketing`
* **Role Name**: `Local Marketing Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Marketing module to enable Local Marketing Manager personnel to oversee, audit, and coordinate operations related to localmarketingmanagerdashboardscreen.`
* **User Story**: `As a Local Marketing Manager, I want to access the LocalMarketingManagerDashboardScreen within the Primecare Marketing application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `LocalMarketingManagerDashboardScreen`
* **Acceptance Criteria**:
- The LocalMarketingManagerDashboardScreen route loads successfully within the Primecare Marketing workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Local Marketing Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `local_marketing_manager_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `local_marketing_manager_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `local_marketing_manager_dashboard-content` (Type: layout, Required: 1)
* **localmarketingmanagerdashboard_title** -> `localmarketingmanagerdashboard-title` (Type: header, Required: 0)
* **localmarketingmanagerdashboard_screen** -> `localmarketingmanagerdashboard-screen` (Type: layout, Required: 0)
* **localmarketingmanagerdashboard_content** -> `localmarketingmanagerdashboard-content` (Type: layout, Required: 0)
* **localmarketingmanagerdashboard_btn_2** -> `localmarketingmanagerdashboard-btn-2` (Type: button, Required: 0)
* **localmarketingmanagerdashboard_btn_1** -> `localmarketingmanagerdashboard-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `59` (Required: 1)
* Component ID: `593` (Required: 1)
* Component ID: `1127` (Required: 1)
* Component ID: `2033` (Required: 1)
* Component ID: `2034` (Required: 1)
* Component ID: `2035` (Required: 1)
* Component ID: `2036` (Required: 1)
* Component ID: `2037` (Required: 1)
* Component ID: `2038` (Required: 1)
* Component ID: `2039` (Required: 1)
* Component ID: `2040` (Required: 1)
* Component ID: `2041` (Required: 1)
* Component ID: `2042` (Required: 1)

## 7. API / Data Mapping
* API ID: `4306` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `local_marketing_manager_dashboard_runtime`
* **Test Name**: `LocalMarketingManagerDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `LocalMarketingManagerDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `local_marketing`)
2. **visit** (Selector: `None`, Value: `/offices/marketing/roles/local_marketing_manager/dashboard`)
3. **should_be_visible** (Selector: `local_marketing_manager_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `local_marketing_manager_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `local_marketing_manager_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
