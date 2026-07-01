# SCREEN DATA CONTEXT: service_procurement

Below are the database records from `governance.db` used to configure and build the **Guest - ServiceProcurementScreen** screen.

---

## 1. Screen Record
* **ID**: `985`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `service_procurement`
* **Screen Name**: `ServiceProcurementScreen`
* **Route Path**: `/generated/service-procurement`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/operations/service_procurement_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to service procurement.`
* **User Story**: `As a Guest, I want to access the Service Procurement within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Service Procurement`
* **Acceptance Criteria**:
- The Service Procurement route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `service_procurement-screen` (Type: layout, Required: 1)
* **page_title** -> `service_procurement-title` (Type: header, Required: 1)
* **primary_content** -> `service_procurement-content` (Type: layout, Required: 1)
* **service_procurement_screen_outlinedbutton_button_1** -> `service_procurement_screen_outlinedbutton_button_1` (Type: button, Required: 0)
* **service_procurement_screen_textfield_input_2** -> `service_procurement_screen_textfield_input_2` (Type: field, Required: 0)
* **service_procurement_screen_elevatedbutton_button_1** -> `service_procurement_screen_elevatedbutton_button_1` (Type: button, Required: 0)
* **service_procurement_screen_textfield_input_1** -> `service_procurement_screen_textfield_input_1` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8365` (Required: 1)
* Component ID: `8366` (Required: 1)
* Component ID: `8367` (Required: 1)
* Component ID: `8368` (Required: 1)
* Component ID: `8369` (Required: 1)
* Component ID: `8370` (Required: 1)
* Component ID: `8371` (Required: 1)

## 7. API / Data Mapping
* API ID: `5431` (Required: 1)
* API ID: `5432` (Required: 1)
* API ID: `5433` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `service_procurement_runtime`
* **Test Name**: `Service Procurement Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Service Procurement`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Service Procurement`)
4. **click_sidebar_link** (Selector: `None`, Value: `Service Procurement`)
5. **check_url** (Selector: `None`, Value: `/generated/service-procurement`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
