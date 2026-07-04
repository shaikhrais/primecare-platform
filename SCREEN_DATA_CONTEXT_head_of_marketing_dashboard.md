# SCREEN DATA CONTEXT: head_of_marketing_dashboard

Below are the database records from `governance.db` used to configure and build the **Head of Marketing - HeadOfMarketingDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `50`
* **App ID**: `11`
* **Role ID**: `38`
* **Screen Code**: `head_of_marketing_dashboard`
* **Screen Name**: `HeadOfMarketingDashboardScreen`
* **Route Path**: `/offices/corporate/roles/head_of_marketing/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/head_of_marketing_dashboard.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Marketing module to enable Head of Marketing personnel to oversee, audit, and coordinate operations related to headofmarketingdashboardscreen.`
* **User Story**: `As a Head of Marketing, I want to access the HeadOfMarketingDashboardScreen within the Primecare Marketing application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HeadOfMarketingDashboardScreen`
* **Acceptance Criteria**:
- The HeadOfMarketingDashboardScreen route loads successfully within the Primecare Marketing workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Marketing access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_marketing_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_marketing_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_marketing_dashboard-content` (Type: layout, Required: 1)
* **head_of_marketing_dashboard_iconbutton_button_1** -> `head_of_marketing_dashboard_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `58` (Required: 1)
* Component ID: `592` (Required: 1)
* Component ID: `1126` (Required: 1)
* Component ID: `2023` (Required: 1)
* Component ID: `2024` (Required: 1)
* Component ID: `2025` (Required: 1)
* Component ID: `2026` (Required: 1)
* Component ID: `2027` (Required: 1)
* Component ID: `2028` (Required: 1)
* Component ID: `2029` (Required: 1)
* Component ID: `2030` (Required: 1)
* Component ID: `2031` (Required: 1)
* Component ID: `2032` (Required: 1)

## 7. API / Data Mapping
* API ID: `4305` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_marketing_dashboard_runtime`
* **Test Name**: `HeadOfMarketingDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HeadOfMarketingDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `marketing`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/head_of_marketing/dashboard`)
3. **should_be_visible** (Selector: `head_of_marketing_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `head_of_marketing_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `head_of_marketing_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
