# SCREEN DATA CONTEXT: payment_tracking

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - PaymentTrackingScreen** screen.

---

## 1. Screen Record
* **ID**: `518`
* **App ID**: `5`
* **Role ID**: `59`
* **Screen Code**: `payment_tracking`
* **Screen Name**: `PaymentTrackingScreen`
* **Route Path**: `/staff/payment-tracking`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/payment_tracking_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to paymenttrackingscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the PaymentTrackingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PaymentTrackingScreen`
* **Acceptance Criteria**:
- The PaymentTrackingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `payment_tracking-screen` (Type: layout, Required: 1)
* **page_title** -> `payment_tracking-title` (Type: header, Required: 1)
* **primary_content** -> `payment_tracking-content` (Type: layout, Required: 1)
* **paymenttracking_btn_5** -> `paymenttracking-btn-5` (Type: button, Required: 0)
* **paymenttracking_btn_3** -> `paymenttracking-btn-3` (Type: button, Required: 0)
* **paymenttracking_loading** -> `paymenttracking-loading` (Type: loading, Required: 0)
* **paymenttracking_title** -> `paymenttracking-title` (Type: header, Required: 0)
* **paymenttracking_content** -> `paymenttracking-content` (Type: layout, Required: 0)
* **paymenttracking_screen** -> `paymenttracking-screen` (Type: layout, Required: 0)
* **paymenttracking_btn_1** -> `paymenttracking-btn-1` (Type: button, Required: 0)
* **paymenttracking_btn_2** -> `paymenttracking-btn-2` (Type: button, Required: 0)
* **paymenttracking_btn_4** -> `paymenttracking-btn-4` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `447` (Required: 1)
* Component ID: `981` (Required: 1)
* Component ID: `1515` (Required: 1)
* Component ID: `5556` (Required: 1)
* Component ID: `5557` (Required: 1)
* Component ID: `5558` (Required: 1)
* Component ID: `5559` (Required: 1)
* Component ID: `5560` (Required: 1)
* Component ID: `5561` (Required: 1)
* Component ID: `5562` (Required: 1)
* Component ID: `5563` (Required: 1)
* Component ID: `5564` (Required: 1)
* Component ID: `5565` (Required: 1)

## 7. API / Data Mapping
* API ID: `4834` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `payment_tracking_runtime`
* **Test Name**: `PaymentTrackingScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Payment Tracking`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Payment Tracking`)
4. **click_sidebar_link** (Selector: `None`, Value: `Payment Tracking`)
5. **check_url** (Selector: `None`, Value: `/staff/payment-tracking`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
