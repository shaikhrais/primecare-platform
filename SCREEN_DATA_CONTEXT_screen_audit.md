# SCREEN DATA CONTEXT: screen_audit

Below are the database records from `governance.db` used to configure and build the **Guest - ScreenAuditScreen** screen.

---

## 1. Screen Record
* **ID**: `1028`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `screen_audit`
* **Screen Name**: `ScreenAuditScreen`
* **Route Path**: `/generated/screen-audit`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/audit_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to screen audit.`
* **User Story**: `As a Guest, I want to access the Screen Audit within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Screen Audit`
* **Acceptance Criteria**:
- The Screen Audit route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `screen_audit-screen` (Type: layout, Required: 1)
* **page_title** -> `screen_audit-title` (Type: header, Required: 1)
* **primary_content** -> `screen_audit-content` (Type: layout, Required: 1)
* **audit_content** -> `audit-content` (Type: layout, Required: 0)
* **gov_dashboard_generate_audit_report** -> `gov-dashboard-generate-audit-report` (Type: custom, Required: 0)
* **gov_dashboard_send_compliance_alert** -> `gov-dashboard-send-compliance-alert` (Type: custom, Required: 0)
* **gov_dashboard_refresh_data** -> `gov-dashboard-refresh-data` (Type: custom, Required: 0)
* **gov_dashboard_update_governance_document** -> `gov-dashboard-update-governance-document` (Type: custom, Required: 0)
* **gov_dashboard_view_training_resources** -> `gov-dashboard-view-training-resources` (Type: custom, Required: 0)

## 6. Component Mapping
* Component ID: `8652` (Required: 1)
* Component ID: `8653` (Required: 1)
* Component ID: `8654` (Required: 1)
* Component ID: `8655` (Required: 1)
* Component ID: `8656` (Required: 1)

## 7. API / Data Mapping
* API ID: `4931` (Required: 1)
* API ID: `4932` (Required: 1)
* API ID: `4933` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `screen_audit_runtime`
* **Test Name**: `Screen Audit Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Screen Audit`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/screen-audit`)
3. **should_be_visible** (Selector: `screen_audit-screen`, Value: `None`)
4. **should_be_visible** (Selector: `screen_audit-title`, Value: `None`)
5. **should_be_visible** (Selector: `screen_audit-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
