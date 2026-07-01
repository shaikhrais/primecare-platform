# SCREEN DATA CONTEXT: lead_conversion_funnel

Below are the database records from `governance.db` used to configure and build the **Guest - LeadConversionFunnelScreen** screen.

---

## 1. Screen Record
* **ID**: `977`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `lead_conversion_funnel`
* **Screen Name**: `LeadConversionFunnelScreen`
* **Route Path**: `/generated/lead-conversion-funnel`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/marketing/lead_conversion_funnel.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to lead conversion funnel.`
* **User Story**: `As a Guest, I want to access the Lead Conversion Funnel within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Lead Conversion Funnel`
* **Acceptance Criteria**:
- The Lead Conversion Funnel route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `lead_conversion_funnel-screen` (Type: layout, Required: 1)
* **page_title** -> `lead_conversion_funnel-title` (Type: header, Required: 1)
* **primary_content** -> `lead_conversion_funnel-content` (Type: layout, Required: 1)
* **lead_conversion_funnel_iconbutton_button_1** -> `lead_conversion_funnel_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8325` (Required: 1)
* Component ID: `8326` (Required: 1)
* Component ID: `8327` (Required: 1)
* Component ID: `8328` (Required: 1)
* Component ID: `8329` (Required: 1)

## 7. API / Data Mapping
* API ID: `5417` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `lead_conversion_funnel_runtime`
* **Test Name**: `Lead Conversion Funnel Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Lead Conversion Funnel`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Lead Conversion Funnel`)
4. **click_sidebar_link** (Selector: `None`, Value: `Lead Conversion Funnel`)
5. **check_url** (Selector: `None`, Value: `/generated/lead-conversion-funnel`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
