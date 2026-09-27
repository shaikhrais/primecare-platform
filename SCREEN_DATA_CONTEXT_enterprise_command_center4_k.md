# SCREEN DATA CONTEXT: enterprise_command_center4_k

Below are the database records from `governance.db` used to configure and build the **Chief Executive Officer (CEO) - EnterpriseCommandCenter4KScreen** screen.

---

## 1. Screen Record
* **ID**: `591`
* **App ID**: `7`
* **Role ID**: `20`
* **Screen Code**: `enterprise_command_center4_k`
* **Screen Name**: `EnterpriseCommandCenter4KScreen`
* **Route Path**: `/executive/enterprise-command-center4-k`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/enterprise_command_center4_k_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `20`
* **Role Code**: `ceo`
* **Role Name**: `Chief Executive Officer (CEO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Executive Officer (CEO) personnel to oversee, audit, and coordinate operations related to enterprisecommandcenter4kscreen.`
* **User Story**: `As a Chief Executive Officer (CEO), I want to access the EnterpriseCommandCenter4KScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `EnterpriseCommandCenter4KScreen`
* **Acceptance Criteria**:
- The EnterpriseCommandCenter4KScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Executive Officer (CEO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `enterprise_command_center4_k-screen` (Type: layout, Required: 1)
* **page_title** -> `enterprise_command_center4_k-title` (Type: header, Required: 1)
* **primary_content** -> `enterprise_command_center4_k-content` (Type: layout, Required: 1)
* **enterprisecommandcenter4k_btn_2** -> `enterprisecommandcenter4k-btn-2` (Type: button, Required: 0)
* **enterprisecommandcenter4k_screen** -> `enterprisecommandcenter4k-screen` (Type: layout, Required: 0)
* **enterprisecommandcenter4k_btn_3** -> `enterprisecommandcenter4k-btn-3` (Type: button, Required: 0)
* **enterprisecommandcenter4k_title** -> `enterprisecommandcenter4k-title` (Type: header, Required: 0)
* **enterprisecommandcenter4k_btn_1** -> `enterprisecommandcenter4k-btn-1` (Type: button, Required: 0)
* **enterprisecommandcenter4k_content** -> `enterprisecommandcenter4k-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `515` (Required: 1)
* Component ID: `1049` (Required: 1)
* Component ID: `1583` (Required: 1)
* Component ID: `6163` (Required: 1)
* Component ID: `6164` (Required: 1)
* Component ID: `6165` (Required: 1)
* Component ID: `6166` (Required: 1)
* Component ID: `6167` (Required: 1)
* Component ID: `6168` (Required: 1)
* Component ID: `6169` (Required: 1)
* Component ID: `6170` (Required: 1)
* Component ID: `6171` (Required: 1)
* Component ID: `6172` (Required: 1)

## 7. API / Data Mapping
* API ID: `4940` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `enterprise_command_center4_k_runtime`
* **Test Name**: `EnterpriseCommandCenter4KScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `EnterpriseCommandCenter4KScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ceo`)
2. **visit** (Selector: `None`, Value: `/executive/enterprise-command-center4-k`)
3. **should_be_visible** (Selector: `enterprise_command_center4_k-screen`, Value: `None`)
4. **should_be_visible** (Selector: `enterprise_command_center4_k-title`, Value: `None`)
5. **should_be_visible** (Selector: `enterprise_command_center4_k-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
