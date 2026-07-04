# SCREEN DATA CONTEXT: response_bot_audit

Below are the database records from `governance.db` used to configure and build the **Guest - ResponseBotAuditScreen** screen.

---

## 1. Screen Record
* **ID**: `926`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `response_bot_audit`
* **Screen Name**: `ResponseBotAuditScreen`
* **Route Path**: `/generated/response-bot-audit`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/response_bot_audit_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to response bot audit.`
* **User Story**: `As a Guest, I want to access the Response Bot Audit within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Response Bot Audit`
* **Acceptance Criteria**:
- The Response Bot Audit route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `response_bot_audit-screen` (Type: layout, Required: 1)
* **page_title** -> `response_bot_audit-title` (Type: header, Required: 1)
* **primary_content** -> `response_bot_audit-content` (Type: layout, Required: 1)
* **response_bot_audit_screen_iconbutton_button_1** -> `response_bot_audit_screen_iconbutton_button_1` (Type: button, Required: 0)
* **response_bot_audit_screen_textfield_input_1** -> `response_bot_audit_screen_textfield_input_1` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8074` (Required: 1)
* Component ID: `8075` (Required: 1)
* Component ID: `8076` (Required: 1)
* Component ID: `8077` (Required: 1)

## 7. API / Data Mapping
* API ID: `5352` (Required: 1)
* API ID: `5353` (Required: 1)
* API ID: `5354` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `response_bot_audit_runtime`
* **Test Name**: `Response Bot Audit Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Response Bot Audit`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/response-bot-audit`)
3. **should_be_visible** (Selector: `response_bot_audit-screen`, Value: `None`)
4. **should_be_visible** (Selector: `response_bot_audit-title`, Value: `None`)
5. **should_be_visible** (Selector: `response_bot_audit-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
