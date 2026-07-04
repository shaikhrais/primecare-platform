# SCREEN DATA CONTEXT: screen_status

Below are the database records from `governance.db` used to configure and build the **Guest - ScreenStatusScreen** screen.

---

## 1. Screen Record
* **ID**: `825`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `screen_status`
* **Screen Name**: `ScreenStatusScreen`
* **Route Path**: `/governance/screen-status`
* **Actual File Path**: `apps/primecare_governance/lib/features/audit/screens/screen_status_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to screen status.`
* **User Story**: `As a Guest, I want to access the Screen Status within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Screen Status`
* **Acceptance Criteria**:
- The Screen Status route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `screen_status-screen` (Type: layout, Required: 1)
* **page_title** -> `screen_status-title` (Type: header, Required: 1)
* **primary_content** -> `screen_status-content` (Type: layout, Required: 1)
* **data_cy_screen_search_input** -> `data-cy-screen-search-input` (Type: field, Required: 0)
* **screen_status_btn_refresh** -> `screen-status-btn-refresh` (Type: button, Required: 0)
* **data_cy_tab_strings** -> `data-cy-tab-strings` (Type: custom, Required: 0)
* **data_cy_lang_chip_$langcode** -> `data-cy-lang-chip-$langCode` (Type: custom, Required: 0)
* **data_cy_screen_item_${screen.screenname}** -> `data-cy-screen-item-${screen.screenName}` (Type: layout, Required: 0)
* **data_cy_tab_buttons** -> `data-cy-tab-buttons` (Type: button, Required: 0)
* **data_cy_tab_components** -> `data-cy-tab-components` (Type: custom, Required: 0)
* **data_cy_app_dropdown** -> `data-cy-app-dropdown` (Type: custom, Required: 0)
* **data_cy_tabs_bar** -> `data-cy-tabs-bar` (Type: custom, Required: 0)
* **data_cy_tab_compliance** -> `data-cy-tab-compliance` (Type: custom, Required: 0)

## 6. Component Mapping
* Component ID: `7526` (Required: 1)
* Component ID: `7527` (Required: 1)
* Component ID: `7528` (Required: 1)
* Component ID: `7529` (Required: 1)
* Component ID: `7530` (Required: 1)
* Component ID: `7531` (Required: 1)
* Component ID: `7532` (Required: 1)

## 7. API / Data Mapping
* API ID: `5218` (Required: 1)
* API ID: `5219` (Required: 1)
* API ID: `5220` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `screen_status_runtime`
* **Test Name**: `Screen Status Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Screen Status`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/governance/screen-status`)
3. **should_be_visible** (Selector: `screen_status-screen`, Value: `None`)
4. **should_be_visible** (Selector: `screen_status-title`, Value: `None`)
5. **should_be_visible** (Selector: `screen_status-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
