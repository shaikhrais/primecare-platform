# SCREEN DATA CONTEXT: email_marketing_automator

Below are the database records from `governance.db` used to configure and build the **Guest - EmailMarketingAutomatorScreen** screen.

---

## 1. Screen Record
* **ID**: `975`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `email_marketing_automator`
* **Screen Name**: `EmailMarketingAutomatorScreen`
* **Route Path**: `/generated/email-marketing-automator`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/marketing/email_marketing_automator.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to email marketing automator.`
* **User Story**: `As a Guest, I want to access the Email Marketing Automator within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Email Marketing Automator`
* **Acceptance Criteria**:
- The Email Marketing Automator route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `email_marketing_automator-screen` (Type: layout, Required: 1)
* **page_title** -> `email_marketing_automator-title` (Type: header, Required: 1)
* **primary_content** -> `email_marketing_automator-content` (Type: layout, Required: 1)
* **email_marketing_automator_iconbutton_button_1** -> `email_marketing_automator_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8316` (Required: 1)
* Component ID: `8317` (Required: 1)
* Component ID: `8318` (Required: 1)
* Component ID: `8319` (Required: 1)
* Component ID: `8320` (Required: 1)

## 7. API / Data Mapping
* API ID: `5415` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `email_marketing_automator_runtime`
* **Test Name**: `Email Marketing Automator Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Email Marketing Automator`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Email Marketing Automator`)
4. **click_sidebar_link** (Selector: `None`, Value: `Email Marketing Automator`)
5. **check_url** (Selector: `None`, Value: `/generated/email-marketing-automator`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
