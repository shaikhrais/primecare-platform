# SCREEN DATA CONTEXT: reset_password

Below are the database records from `governance.db` used to configure and build the **Guest - ResetPasswordScreen** screen.

---

## 1. Screen Record
* **ID**: `950`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `reset_password`
* **Screen Name**: `ResetPasswordScreen`
* **Route Path**: `/generated/reset-password`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/auth/reset_password_view.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to reset password.`
* **User Story**: `As a Guest, I want to access the Reset Password within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Reset Password`
* **Acceptance Criteria**:
- The Reset Password route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `reset_password-screen` (Type: layout, Required: 1)
* **page_title** -> `reset_password-title` (Type: header, Required: 1)
* **primary_content** -> `reset_password-content` (Type: layout, Required: 1)
* **reset_password_view_elevatedbutton_button_1** -> `reset_password_view_elevatedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8182` (Required: 1)
* Component ID: `8183` (Required: 1)
* Component ID: `8184` (Required: 1)
* Component ID: `8185` (Required: 1)

## 7. API / Data Mapping
* API ID: `5386` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `reset_password_runtime`
* **Test Name**: `Reset Password Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Reset Password`
* **Expected Layout**: `dashboard`

### Test Steps
1. **visit** (Selector: `None`, Value: `/generated/reset-password`)
2. **should_be_visible** (Selector: `reset_password-screen`, Value: `None`)
3. **should_be_visible** (Selector: `reset_password-title`, Value: `None`)
4. **should_be_visible** (Selector: `reset_password-content`, Value: `None`)
5. **check_no_console_error** (Selector: `None`, Value: `None`)
6. **screenshot** (Selector: `None`, Value: `None`)
