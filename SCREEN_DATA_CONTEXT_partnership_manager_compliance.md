# SCREEN DATA CONTEXT: partnership_manager_compliance

Below are the database records from `governance.db` used to configure and build the **Partnership Manager - PartnershipManagerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `214`
* **App ID**: `1`
* **Role ID**: `41`
* **Screen Code**: `partnership_manager_compliance`
* **Screen Name**: `PartnershipManagerComplianceScreen`
* **Route Path**: `/management/partnership-manager-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/partnership_manager_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `41`
* **Role Code**: `partnership`
* **Role Name**: `Partnership Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Partnership Manager personnel to oversee, audit, and coordinate operations related to partnershipmanagercompliancescreen.`
* **User Story**: `As a Partnership Manager, I want to access the PartnershipManagerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PartnershipManagerComplianceScreen`
* **Acceptance Criteria**:
- The PartnershipManagerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Partnership Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `partnership_manager_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `partnership_manager_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `partnership_manager_compliance-content` (Type: layout, Required: 1)
* **partnershipmanagercompliance_btn_3** -> `partnershipmanagercompliance-btn-3` (Type: button, Required: 0)
* **partnershipmanagercompliance_screen** -> `partnershipmanagercompliance-screen` (Type: layout, Required: 0)
* **partnershipmanagercompliance_content** -> `partnershipmanagercompliance-content` (Type: layout, Required: 0)
* **partnershipmanagercompliance_title** -> `partnershipmanagercompliance-title` (Type: header, Required: 0)
* **partnershipmanagercompliance_btn_2** -> `partnershipmanagercompliance-btn-2` (Type: button, Required: 0)
* **partnershipmanagercompliance_btn_1** -> `partnershipmanagercompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `222` (Required: 1)
* Component ID: `756` (Required: 1)
* Component ID: `1290` (Required: 1)
* Component ID: `3489` (Required: 1)
* Component ID: `3490` (Required: 1)
* Component ID: `3491` (Required: 1)
* Component ID: `3492` (Required: 1)
* Component ID: `3493` (Required: 1)
* Component ID: `3494` (Required: 1)
* Component ID: `3495` (Required: 1)

## 7. API / Data Mapping
* API ID: `4503` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `partnership_manager_compliance_runtime`
* **Test Name**: `PartnershipManagerComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PartnershipManagerComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `partnership`)
2. **visit** (Selector: `None`, Value: `/management/partnership-manager-compliance`)
3. **should_be_visible** (Selector: `partnership_manager_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `partnership_manager_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `partnership_manager_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
