# SCREEN DATA CONTEXT: hsw_adl_logger

Below are the database records from `governance.db` used to configure and build the **Home Support Worker - HswAdlLoggerScreen** screen.

---

## 1. Screen Record
* **ID**: `82`
* **App ID**: `1`
* **Role ID**: `52`
* **Screen Code**: `hsw_adl_logger`
* **Screen Name**: `HswAdlLoggerScreen`
* **Route Path**: `/clinical/hsw-adl-logger`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/hsw_adl_logger_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `52`
* **Role Code**: `hsw`
* **Role Name**: `Home Support Worker`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Home Support Worker personnel to oversee, audit, and coordinate operations related to hswadlloggerscreen.`
* **User Story**: `As a Home Support Worker, I want to access the HswAdlLoggerScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HswAdlLoggerScreen`
* **Acceptance Criteria**:
- The HswAdlLoggerScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Home Support Worker access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hsw_adl_logger-screen` (Type: layout, Required: 1)
* **page_title** -> `hsw_adl_logger-title` (Type: header, Required: 1)
* **primary_content** -> `hsw_adl_logger-content` (Type: layout, Required: 1)
* **data_cy_hsw_adl_checklist_form** -> `data-cy-hsw-adl-checklist-form` (Type: data_display, Required: 0)
* **data_cy_hsw_meals_assistance_logger** -> `data-cy-hsw-meals-assistance-logger` (Type: custom, Required: 0)
* **data_cy_hsw_hygiene_support_checkboxes** -> `data-cy-hsw-hygiene-support-checkboxes` (Type: custom, Required: 0)
* **hswadllogger_btn_1** -> `hswadllogger-btn-1` (Type: button, Required: 0)
* **save_adl_draft** -> `save_adl_draft` (Type: custom, Required: 0)
* **hswadllogger_title** -> `hswadllogger-title` (Type: header, Required: 0)
* **submit_adl_logs** -> `submit_adl_logs` (Type: custom, Required: 0)
* **hswadllogger_screen** -> `hswadllogger-screen` (Type: layout, Required: 0)
* **hswadllogger_content** -> `hswadllogger-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `90` (Required: 1)
* Component ID: `624` (Required: 1)
* Component ID: `1158` (Required: 1)
* Component ID: `2315` (Required: 1)
* Component ID: `2316` (Required: 1)
* Component ID: `2317` (Required: 1)
* Component ID: `2318` (Required: 1)
* Component ID: `2319` (Required: 1)

## 7. API / Data Mapping
* API ID: `4353` (Required: 1)
* API ID: `4354` (Required: 1)
* API ID: `4355` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hsw_adl_logger_runtime`
* **Test Name**: `HswAdlLoggerScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HswAdlLoggerScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hsw`)
2. **visit** (Selector: `None`, Value: `/clinical/hsw-adl-logger`)
3. **should_be_visible** (Selector: `hsw_adl_logger-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hsw_adl_logger-title`, Value: `None`)
5. **should_be_visible** (Selector: `hsw_adl_logger-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
