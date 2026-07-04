# SCREEN DATA CONTEXT: offer_management

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - OfferManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `522`
* **App ID**: `5`
* **Role ID**: `45`
* **Screen Code**: `offer_management`
* **Screen Name**: `OfferManagementScreen`
* **Route Path**: `/staff/offer-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/offer_management_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `45`
* **Role Code**: `hr_hiring`
* **Role Name**: `Talent Acquisition Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to offermanagementscreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the OfferManagementScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OfferManagementScreen`
* **Acceptance Criteria**:
- The OfferManagementScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `offer_management-screen` (Type: layout, Required: 1)
* **page_title** -> `offer_management-title` (Type: header, Required: 1)
* **primary_content** -> `offer_management-content` (Type: layout, Required: 1)
* **offermanagement_screen** -> `offermanagement-screen` (Type: layout, Required: 0)
* **offermanagement_btn_5** -> `offermanagement-btn-5` (Type: button, Required: 0)
* **offermanagement_loading** -> `offermanagement-loading` (Type: loading, Required: 0)
* **offermanagement_content** -> `offermanagement-content` (Type: layout, Required: 0)
* **offermanagement_title** -> `offermanagement-title` (Type: header, Required: 0)
* **offermanagement_btn_1** -> `offermanagement-btn-1` (Type: button, Required: 0)
* **offermanagement_btn_3** -> `offermanagement-btn-3` (Type: button, Required: 0)
* **offermanagement_btn_4** -> `offermanagement-btn-4` (Type: button, Required: 0)
* **offermanagement_btn_2** -> `offermanagement-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `451` (Required: 1)
* Component ID: `985` (Required: 1)
* Component ID: `1519` (Required: 1)
* Component ID: `5595` (Required: 1)
* Component ID: `5596` (Required: 1)
* Component ID: `5597` (Required: 1)
* Component ID: `5598` (Required: 1)
* Component ID: `5599` (Required: 1)
* Component ID: `5600` (Required: 1)
* Component ID: `5601` (Required: 1)
* Component ID: `5602` (Required: 1)
* Component ID: `5603` (Required: 1)
* Component ID: `5604` (Required: 1)

## 7. API / Data Mapping
* API ID: `4838` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `offer_management_runtime`
* **Test Name**: `OfferManagementScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OfferManagementScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **visit** (Selector: `None`, Value: `/staff/offer-management`)
3. **should_be_visible** (Selector: `offer_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `offer_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `offer_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
