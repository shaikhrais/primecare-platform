# SCREEN DATA CONTEXT: customer_support_dashboard

Below are the database records from `governance.db` used to configure and build the **Dynamic Screen Viewer - CustomerSupportDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `16`
* **App ID**: `5`
* **Role ID**: `16`
* **Screen Code**: `customer_support_dashboard`
* **Screen Name**: `CustomerSupportDashboardScreen`
* **Route Path**: `/common/customer-support-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/customer_support_dashboard.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `16`
* **Role Code**: `dynamic`
* **Role Name**: `Dynamic Screen Viewer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Dynamic Screen Viewer personnel to oversee, audit, and coordinate operations related to customersupportdashboardscreen.`
* **User Story**: `As a Dynamic Screen Viewer, I want to access the CustomerSupportDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CustomerSupportDashboardScreen`
* **Acceptance Criteria**:
- The CustomerSupportDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Dynamic Screen Viewer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `customer_support_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `customer_support_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `customer_support_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `24` (Required: 1)
* Component ID: `558` (Required: 1)
* Component ID: `1092` (Required: 1)
* Component ID: `1734` (Required: 1)
* Component ID: `1735` (Required: 1)
* Component ID: `1736` (Required: 1)
* Component ID: `1737` (Required: 1)
* Component ID: `1738` (Required: 1)
* Component ID: `1739` (Required: 1)
* Component ID: `1740` (Required: 1)

## 7. API / Data Mapping
* API ID: `4265` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `customer_support_dashboard_runtime`
* **Test Name**: `CustomerSupportDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CustomerSupportDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `dynamic`)
2. **visit** (Selector: `None`, Value: `/common/customer-support-dashboard`)
3. **should_be_visible** (Selector: `customer_support_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `customer_support_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `customer_support_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
