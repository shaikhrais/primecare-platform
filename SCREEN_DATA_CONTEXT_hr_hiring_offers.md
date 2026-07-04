# SCREEN DATA CONTEXT: hr_hiring_offers

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - HrHiringOffersScreen** screen.

---

## 1. Screen Record
* **ID**: `317`
* **App ID**: `5`
* **Role ID**: `45`
* **Screen Code**: `hr_hiring_offers`
* **Screen Name**: `HrHiringOffersScreen`
* **Route Path**: `/offices/franchise/roles/hr_hiring/offers`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/hr_hiring_offers_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to hrhiringoffersscreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the HrHiringOffersScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrHiringOffersScreen`
* **Acceptance Criteria**:
- The HrHiringOffersScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_hiring_offers-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_hiring_offers-title` (Type: header, Required: 1)
* **primary_content** -> `hr_hiring_offers-content` (Type: layout, Required: 1)
* **hrhiringoffers_btn_4** -> `hrhiringoffers-btn-4` (Type: button, Required: 0)
* **hrhiringoffers_btn_1** -> `hrhiringoffers-btn-1` (Type: button, Required: 0)
* **hrhiringoffers_screen** -> `hrhiringoffers-screen` (Type: layout, Required: 0)
* **hrhiringoffers_btn_2** -> `hrhiringoffers-btn-2` (Type: button, Required: 0)
* **hrhiringoffers_loading** -> `hrhiringoffers-loading` (Type: loading, Required: 0)
* **hrhiringoffers_btn_3** -> `hrhiringoffers-btn-3` (Type: button, Required: 0)
* **hrhiringoffers_btn_5** -> `hrhiringoffers-btn-5` (Type: button, Required: 0)
* **hrhiringoffers_title** -> `hrhiringoffers-title` (Type: header, Required: 0)
* **hrhiringoffers_content** -> `hrhiringoffers-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `325` (Required: 1)
* Component ID: `859` (Required: 1)
* Component ID: `1393` (Required: 1)
* Component ID: `4435` (Required: 1)
* Component ID: `4436` (Required: 1)
* Component ID: `4437` (Required: 1)
* Component ID: `4438` (Required: 1)
* Component ID: `4439` (Required: 1)
* Component ID: `4440` (Required: 1)
* Component ID: `4441` (Required: 1)
* Component ID: `4442` (Required: 1)

## 7. API / Data Mapping
* API ID: `4646` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_hiring_offers_runtime`
* **Test Name**: `HrHiringOffersScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrHiringOffersScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/hr_hiring/offers`)
3. **should_be_visible** (Selector: `hr_hiring_offers-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_hiring_offers-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_hiring_offers-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
