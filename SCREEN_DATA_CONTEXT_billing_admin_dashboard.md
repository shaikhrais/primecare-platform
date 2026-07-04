# SCREEN DATA CONTEXT: billing_admin_dashboard

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - BillingAdminDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `65`
* **App ID**: `5`
* **Role ID**: `59`
* **Screen Code**: `billing_admin_dashboard`
* **Screen Name**: `BillingAdminDashboardScreen`
* **Route Path**: `/offices/franchise/roles/billing_admin/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/billing_admin_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to billingadmindashboardscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the BillingAdminDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BillingAdminDashboardScreen`
* **Acceptance Criteria**:
- The BillingAdminDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `billing_admin_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `billing_admin_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `billing_admin_dashboard-content` (Type: layout, Required: 1)
* **billingadmindashboard_title** -> `billingadmindashboard-title` (Type: header, Required: 0)
* **billingadmindashboard_content** -> `billingadmindashboard-content` (Type: layout, Required: 0)
* **billingadmindashboard_btn_2** -> `billingadmindashboard-btn-2` (Type: button, Required: 0)
* **billingadmindashboard_screen** -> `billingadmindashboard-screen` (Type: layout, Required: 0)
* **billingadmindashboard_btn_4** -> `billingadmindashboard-btn-4` (Type: button, Required: 0)
* **billingadmindashboard_btn_3** -> `billingadmindashboard-btn-3` (Type: button, Required: 0)
* **billingadmindashboard_btn_1** -> `billingadmindashboard-btn-1` (Type: button, Required: 0)
* **billingadmindashboard_btn_5** -> `billingadmindashboard-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `73` (Required: 1)
* Component ID: `607` (Required: 1)
* Component ID: `1141` (Required: 1)
* Component ID: `2160` (Required: 1)
* Component ID: `2161` (Required: 1)
* Component ID: `2162` (Required: 1)
* Component ID: `2163` (Required: 1)
* Component ID: `2164` (Required: 1)
* Component ID: `2165` (Required: 1)
* Component ID: `2166` (Required: 1)
* Component ID: `2167` (Required: 1)
* Component ID: `2168` (Required: 1)
* Component ID: `2169` (Required: 1)

## 7. API / Data Mapping
* API ID: `4326` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `billing_admin_dashboard_runtime`
* **Test Name**: `BillingAdminDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `BillingAdminDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/billing_admin/dashboard`)
3. **should_be_visible** (Selector: `billing_admin_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `billing_admin_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `billing_admin_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
