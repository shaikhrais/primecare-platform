# SCREEN DATA CONTEXT: vip_manager_analytics

Below are the database records from `governance.db` used to configure and build the **VIP Client Manager - VIPClientManagerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `609`
* **App ID**: `1`
* **Role ID**: `50`
* **Screen Code**: `vip_manager_analytics`
* **Screen Name**: `VIPClientManagerAnalyticsScreen`
* **Route Path**: `/executive/vip-manager-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/vip_manager_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `50`
* **Role Code**: `vip_manager`
* **Role Name**: `VIP Client Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable VIP Client Manager personnel to oversee, audit, and coordinate operations related to vip client manager analytics.`
* **User Story**: `As a VIP Client Manager, I want to access the VIP Client Manager Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `VIP Client Manager Analytics`
* **Acceptance Criteria**:
- The VIP Client Manager Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only VIP Client Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `vip_manager_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `vip_manager_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `vip_manager_analytics-content` (Type: layout, Required: 1)
* **vip client manager analytics_btn_1** -> `vip client manager analytics-btn-1` (Type: button, Required: 0)
* **vip client manager analytics_screen** -> `vip client manager analytics-screen` (Type: layout, Required: 0)
* **vip client manager analytics_content** -> `vip client manager analytics-content` (Type: layout, Required: 0)
* **vip client manager analytics_btn_3** -> `vip client manager analytics-btn-3` (Type: button, Required: 0)
* **vip client manager analytics_title** -> `vip client manager analytics-title` (Type: header, Required: 0)
* **vip client manager analytics_btn_2** -> `vip client manager analytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `533` (Required: 1)
* Component ID: `1067` (Required: 1)
* Component ID: `1601` (Required: 1)
* Component ID: `6317` (Required: 1)
* Component ID: `6318` (Required: 1)
* Component ID: `6319` (Required: 1)
* Component ID: `6320` (Required: 1)
* Component ID: `6321` (Required: 1)
* Component ID: `6322` (Required: 1)
* Component ID: `6323` (Required: 1)
* Component ID: `6324` (Required: 1)

## 7. API / Data Mapping
* API ID: `4958` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `vip_manager_analytics_runtime`
* **Test Name**: `VIP Client Manager Analytics Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `VIP Client Manager Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `vip_manager`)
2. **visit** (Selector: `None`, Value: `/executive/vip-manager-analytics`)
3. **should_be_visible** (Selector: `vip_manager_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `vip_manager_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `vip_manager_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
