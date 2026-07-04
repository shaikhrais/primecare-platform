# SCREEN DATA CONTEXT: billing_admin_compliance

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - BillingAdminComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `248`
* **App ID**: `1`
* **Role ID**: `59`
* **Screen Code**: `billing_admin_compliance`
* **Screen Name**: `BillingAdminComplianceScreen`
* **Route Path**: `/staff/billing-admin-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/billing_admin_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to billingadmincompliancescreen.`
* **User Story**: `As a Administrative Assistant, I want to access the BillingAdminComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BillingAdminComplianceScreen`
* **Acceptance Criteria**:
- The BillingAdminComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `billing_admin_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `billing_admin_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `billing_admin_compliance-content` (Type: layout, Required: 1)
* **billingadmincompliance_btn_1** -> `billingadmincompliance-btn-1` (Type: button, Required: 0)
* **billingadmincompliance_btn_5** -> `billingadmincompliance-btn-5` (Type: button, Required: 0)
* **billingadmincompliance_btn_3** -> `billingadmincompliance-btn-3` (Type: button, Required: 0)
* **billingadmincompliance_btn_2** -> `billingadmincompliance-btn-2` (Type: button, Required: 0)
* **billingadmincompliance_content** -> `billingadmincompliance-content` (Type: layout, Required: 0)
* **billingadmincompliance_title** -> `billingadmincompliance-title` (Type: header, Required: 0)
* **billingadmincompliance_btn_4** -> `billingadmincompliance-btn-4` (Type: button, Required: 0)
* **billingadmincompliance_screen** -> `billingadmincompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `256` (Required: 1)
* Component ID: `790` (Required: 1)
* Component ID: `1324` (Required: 1)
* Component ID: `3800` (Required: 1)
* Component ID: `3801` (Required: 1)
* Component ID: `3802` (Required: 1)
* Component ID: `3803` (Required: 1)
* Component ID: `3804` (Required: 1)
* Component ID: `3805` (Required: 1)
* Component ID: `3806` (Required: 1)
* Component ID: `3807` (Required: 1)
* Component ID: `3808` (Required: 1)
* Component ID: `3809` (Required: 1)

## 7. API / Data Mapping
* API ID: `4561` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `billing_admin_compliance_runtime`
* **Test Name**: `BillingAdminComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `BillingAdminComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/staff/billing-admin-compliance`)
3. **should_be_visible** (Selector: `billing_admin_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `billing_admin_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `billing_admin_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
