# SCREEN DATA CONTEXT: forgot_password

Below are the database records from `governance.db` used to configure and build the **Guest - ForgotPasswordScreen** screen.

---

## 1. Screen Record
* **ID**: `947`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `forgot_password`
* **Screen Name**: `ForgotPasswordScreen`
* **Route Path**: `/generated/forgot-password`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/auth/forgot_password_view.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to forgot password.`
* **User Story**: `As a Guest, I want to access the Forgot Password within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Forgot Password`
* **Acceptance Criteria**:
- The Forgot Password route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `forgot_password-screen` (Type: layout, Required: 1)
* **page_title** -> `forgot_password-title` (Type: header, Required: 1)
* **primary_content** -> `forgot_password-content` (Type: layout, Required: 1)
* **forgot_password_view_elevatedbutton_button_1** -> `forgot_password_view_elevatedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8167` (Required: 1)
* Component ID: `8168` (Required: 1)
* Component ID: `8169` (Required: 1)

## 7. API / Data Mapping
* API ID: `5383` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `forgot_password_runtime`
* **Test Name**: `Forgot Password Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Forgot Password`
* **Expected Layout**: `dashboard`

### Test Steps
1. **visit** (Selector: `None`, Value: `/generated/forgot-password`)
2. **should_be_visible** (Selector: `forgot_password-screen`, Value: `None`)
3. **should_be_visible** (Selector: `forgot_password-title`, Value: `None`)
4. **should_be_visible** (Selector: `forgot_password-content`, Value: `None`)
5. **check_no_console_error** (Selector: `None`, Value: `None`)
6. **screenshot** (Selector: `None`, Value: `None`)
