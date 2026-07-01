# SCREEN DATA CONTEXT: audit

Below are the database records from `governance.db` used to configure and build the **Governance Officer - ScreenAuditScreen** screen.

---

## 1. Screen Record
* **ID**: `584`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `audit`
* **Screen Name**: `ScreenAuditScreen`
* **Route Path**: `/common/audit`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/audit_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to screenauditscreen.`
* **User Story**: `As a Governance Officer, I want to access the ScreenAuditScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ScreenAuditScreen`
* **Acceptance Criteria**:
- The ScreenAuditScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `audit-screen` (Type: layout, Required: 1)
* **page_title** -> `audit-title` (Type: header, Required: 1)
* **primary_content** -> `audit-content` (Type: layout, Required: 1)
* **gov_dashboard_generate_audit_report** -> `gov-dashboard-generate-audit-report` (Type: custom, Required: 0)
* **gov_dashboard_send_compliance_alert** -> `gov-dashboard-send-compliance-alert` (Type: custom, Required: 0)
* **gov_dashboard_refresh_data** -> `gov-dashboard-refresh-data` (Type: custom, Required: 0)
* **gov_dashboard_update_governance_document** -> `gov-dashboard-update-governance-document` (Type: custom, Required: 0)
* **gov_dashboard_view_training_resources** -> `gov-dashboard-view-training-resources` (Type: custom, Required: 0)

## 6. Component Mapping
* Component ID: `508` (Required: 1)
* Component ID: `1042` (Required: 1)
* Component ID: `1576` (Required: 1)
* Component ID: `6092` (Required: 1)
* Component ID: `6093` (Required: 1)
* Component ID: `6094` (Required: 1)
* Component ID: `6095` (Required: 1)
* Component ID: `6096` (Required: 1)
* Component ID: `6097` (Required: 1)
* Component ID: `6098` (Required: 1)
* Component ID: `6099` (Required: 1)
* Component ID: `6100` (Required: 1)
* Component ID: `6101` (Required: 1)

## 7. API / Data Mapping
* API ID: `4931` (Required: 1)
* API ID: `4932` (Required: 1)
* API ID: `4933` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `audit_runtime`
* **Test Name**: `ScreenAuditScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Screen Audit`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Screen Audit`)
4. **click_sidebar_link** (Selector: `None`, Value: `Screen Audit`)
5. **check_url** (Selector: `None`, Value: `/common/audit`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
