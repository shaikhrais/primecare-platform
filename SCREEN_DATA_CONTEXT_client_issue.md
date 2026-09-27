# SCREEN DATA CONTEXT: client_issue

Below are the database records from `governance.db` used to configure and build the **Customer Support - ClientIssueScreen** screen.

---

## 1. Screen Record
* **ID**: `558`
* **App ID**: `5`
* **Role ID**: `61`
* **Screen Code**: `client_issue`
* **Screen Name**: `ClientIssueScreen`
* **Route Path**: `/staff/client-issue`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/client_issue_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `61`
* **Role Code**: `customer_support`
* **Role Name**: `Customer Support`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Customer Support personnel to oversee, audit, and coordinate operations related to clientissuescreen.`
* **User Story**: `As a Customer Support, I want to access the ClientIssueScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClientIssueScreen`
* **Acceptance Criteria**:
- The ClientIssueScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Customer Support access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `client_issue-screen` (Type: layout, Required: 1)
* **page_title** -> `client_issue-title` (Type: header, Required: 1)
* **primary_content** -> `client_issue-content` (Type: layout, Required: 1)
* **clientissue_screen** -> `clientissue-screen` (Type: layout, Required: 0)
* **clientissue_btn_5** -> `clientissue-btn-5` (Type: button, Required: 0)
* **clientissue_loading** -> `clientissue-loading` (Type: loading, Required: 0)
* **clientissue_title** -> `clientissue-title` (Type: header, Required: 0)
* **clientissue_content** -> `clientissue-content` (Type: layout, Required: 0)
* **clientissue_btn_4** -> `clientissue-btn-4` (Type: button, Required: 0)
* **clientissue_btn_3** -> `clientissue-btn-3` (Type: button, Required: 0)
* **clientissue_btn_1** -> `clientissue-btn-1` (Type: button, Required: 0)
* **clientissue_btn_2** -> `clientissue-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `482` (Required: 1)
* Component ID: `1016` (Required: 1)
* Component ID: `1550` (Required: 1)
* Component ID: `5882` (Required: 1)
* Component ID: `5883` (Required: 1)
* Component ID: `5884` (Required: 1)
* Component ID: `5885` (Required: 1)
* Component ID: `5886` (Required: 1)
* Component ID: `5887` (Required: 1)
* Component ID: `5888` (Required: 1)
* Component ID: `5889` (Required: 1)

## 7. API / Data Mapping
* API ID: `4905` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `client_issue_runtime`
* **Test Name**: `ClientIssueScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClientIssueScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **visit** (Selector: `None`, Value: `/staff/client-issue`)
3. **should_be_visible** (Selector: `client_issue-screen`, Value: `None`)
4. **should_be_visible** (Selector: `client_issue-title`, Value: `None`)
5. **should_be_visible** (Selector: `client_issue-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
