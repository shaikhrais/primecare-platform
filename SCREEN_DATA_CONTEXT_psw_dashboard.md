# SCREEN DATA CONTEXT: psw_dashboard

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - CareDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `61`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `psw_dashboard`
* **Screen Name**: `CareDashboardScreen`
* **Route Path**: `/offices/clinical/roles/psw/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_dashboard/psw_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provide the Personal Support Worker (PSW) with a unified operational command center for viewing their schedule, tracking shifts, checking client details, and logging tasks.`
* **User Story**: `As a PSW, I want to see my upcoming shifts, check in/out of client homes, view assigned tasks, and quickly access vitals logging or incident reporting so I can deliver high-quality, compliant care.`
* **Sidebar Label**: `PSW Dashboard`
* **Acceptance Criteria**:
1. Render upcoming shifts list dynamically.
2. Allow interactive check-in/check-out button action to update shift state.
3. Display active alerts and a shortcut to log vitals or report incidents.

## 5. Required Elements
* **psw-shift-status-card** -> `psw-shift-status-card` (Type: card, Required: 1)
* **psw-start-shift-btn** -> `psw-start-shift-btn` (Type: button, Required: 1)
* **psw-report-incident-btn** -> `psw-report-incident-btn` (Type: button, Required: 1)
* **psw-view-vitals-btn** -> `psw-view-vitals-btn` (Type: button, Required: 1)
* **psw-clients-list** -> `psw-clients-list` (Type: list, Required: 1)

## 6. Component Mapping
* Component ID: `69` (Required: 1)
* Component ID: `603` (Required: 1)
* Component ID: `1137` (Required: 1)
* Component ID: `2122` (Required: 1)
* Component ID: `2123` (Required: 1)
* Component ID: `2124` (Required: 1)
* Component ID: `2125` (Required: 1)
* Component ID: `2126` (Required: 1)
* Component ID: `2127` (Required: 1)
* Component ID: `2128` (Required: 1)
* Component ID: `2129` (Required: 1)

## 7. API / Data Mapping
* API ID: `4316` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_dashboard_runtime`
* **Test Name**: `Care Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Care Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/dashboard`)
3. **should_be_visible** (Selector: `psw-shift-status-card`, Value: `None`)
4. **should_be_visible** (Selector: `psw-start-shift-btn`, Value: `None`)
5. **should_be_visible** (Selector: `psw-report-incident-btn`, Value: `None`)
6. **should_be_visible** (Selector: `psw-view-vitals-btn`, Value: `None`)
7. **should_be_visible** (Selector: `psw-clients-list`, Value: `None`)
8. **check_no_console_error** (Selector: `None`, Value: `None`)
9. **screenshot** (Selector: `None`, Value: `None`)
