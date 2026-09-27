# SCREEN DATA CONTEXT: certification_renewal_alerts

Below are the database records from `governance.db` used to configure and build the **Guest - CertificationRenewalAlertsScreen** screen.

---

## 1. Screen Record
* **ID**: `951`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `certification_renewal_alerts`
* **Screen Name**: `CertificationRenewalAlertsScreen`
* **Route Path**: `/generated/certification-renewal-alerts`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/education/certification_renewal_alerts.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to certification renewal alerts.`
* **User Story**: `As a Guest, I want to access the Certification Renewal Alerts within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Certification Renewal Alerts`
* **Acceptance Criteria**:
- The Certification Renewal Alerts route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `certification_renewal_alerts-screen` (Type: layout, Required: 1)
* **page_title** -> `certification_renewal_alerts-title` (Type: header, Required: 1)
* **primary_content** -> `certification_renewal_alerts-content` (Type: layout, Required: 1)
* **certification_renewal_alerts_iconbutton_button_1** -> `certification_renewal_alerts_iconbutton_button_1` (Type: button, Required: 0)
* **certification_renewal_alerts_elevatedbutton_button_1** -> `certification_renewal_alerts_elevatedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8186` (Required: 1)
* Component ID: `8187` (Required: 1)
* Component ID: `8188` (Required: 1)
* Component ID: `8189` (Required: 1)
* Component ID: `8190` (Required: 1)
* Component ID: `8191` (Required: 1)

## 7. API / Data Mapping
* API ID: `5387` (Required: 1)
* API ID: `5388` (Required: 1)
* API ID: `5389` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `certification_renewal_alerts_runtime`
* **Test Name**: `Certification Renewal Alerts Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Certification Renewal Alerts`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/certification-renewal-alerts`)
3. **should_be_visible** (Selector: `certification_renewal_alerts-screen`, Value: `None`)
4. **should_be_visible** (Selector: `certification_renewal_alerts-title`, Value: `None`)
5. **should_be_visible** (Selector: `certification_renewal_alerts-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
