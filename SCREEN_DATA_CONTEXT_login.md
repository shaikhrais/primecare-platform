# SCREEN DATA CONTEXT: login

Below are the database records from `governance.db` used to configure and build the **Guest - LoginScreen** screen.

---

## 1. Screen Record
* **ID**: `948`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `login`
* **Screen Name**: `LoginScreen`
* **Route Path**: `/generated/login`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/auth/login_view.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to login.`
* **User Story**: `As a Guest, I want to access the Login within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Login`
* **Acceptance Criteria**:
- The Login route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `login-screen` (Type: layout, Required: 1)
* **page_title** -> `login-title` (Type: header, Required: 1)
* **primary_content** -> `login-content` (Type: layout, Required: 1)
* **login_view_elevatedbutton_button_2** -> `login_view_elevatedbutton_button_2` (Type: button, Required: 0)
* **login_view_textbutton_signup** -> `login_view_textbutton_signup` (Type: button, Required: 0)
* **login_view_elevatedbutton_signup_ok** -> `login_view_elevatedbutton_signup_ok` (Type: button, Required: 0)
* **login_view_outlinedbutton_button_1** -> `login_view_outlinedbutton_button_1` (Type: button, Required: 0)
* **login_view_textbutton_button_2** -> `login_view_textbutton_button_2` (Type: button, Required: 0)
* **login_view_textbutton_button_1** -> `login_view_textbutton_button_1` (Type: button, Required: 0)
* **login_view_elevatedbutton_button_1** -> `login_view_elevatedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8170` (Required: 1)
* Component ID: `8171` (Required: 1)
* Component ID: `8172` (Required: 1)
* Component ID: `8173` (Required: 1)
* Component ID: `8174` (Required: 1)
* Component ID: `8175` (Required: 1)
* Component ID: `8176` (Required: 1)

## 7. API / Data Mapping
* API ID: `5384` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `login_runtime`
* **Test Name**: `Login Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Login`
* **Expected Layout**: `dashboard`

### Test Steps
1. **visit** (Selector: `None`, Value: `/generated/login`)
2. **should_be_visible** (Selector: `login-screen`, Value: `None`)
3. **should_be_visible** (Selector: `login-title`, Value: `None`)
4. **should_be_visible** (Selector: `login-content`, Value: `None`)
5. **check_no_console_error** (Selector: `None`, Value: `None`)
6. **screenshot** (Selector: `None`, Value: `None`)
