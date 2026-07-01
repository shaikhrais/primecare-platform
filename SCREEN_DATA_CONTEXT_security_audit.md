# SCREEN DATA CONTEXT: security_audit

Below are the database records from `governance.db` used to configure and build the **Chief Technology Officer (CTO) - SecurityAuditScreen** screen.

---

## 1. Screen Record
* **ID**: `483`
* **App ID**: `7`
* **Role ID**: `24`
* **Screen Code**: `security_audit`
* **Screen Name**: `SecurityAuditScreen`
* **Route Path**: `/executive/security-audit`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/security_audit_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `24`
* **Role Code**: `cto`
* **Role Name**: `Chief Technology Officer (CTO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Technology Officer (CTO) personnel to oversee, audit, and coordinate operations related to securityauditscreen.`
* **User Story**: `As a Chief Technology Officer (CTO), I want to access the SecurityAuditScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SecurityAuditScreen`
* **Acceptance Criteria**:
- The SecurityAuditScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Technology Officer (CTO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `security_audit-screen` (Type: layout, Required: 1)
* **page_title** -> `security_audit-title` (Type: header, Required: 1)
* **primary_content** -> `security_audit-content` (Type: layout, Required: 1)
* **securityaudit_btn_2** -> `securityaudit-btn-2` (Type: button, Required: 0)
* **securityaudit_btn_3** -> `securityaudit-btn-3` (Type: button, Required: 0)
* **securityaudit_title** -> `securityaudit-title` (Type: header, Required: 0)
* **securityaudit_loading** -> `securityaudit-loading` (Type: loading, Required: 0)
* **securityaudit_btn_1** -> `securityaudit-btn-1` (Type: button, Required: 0)
* **securityaudit_content** -> `securityaudit-content` (Type: layout, Required: 0)
* **securityaudit_screen** -> `securityaudit-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `412` (Required: 1)
* Component ID: `946` (Required: 1)
* Component ID: `1480` (Required: 1)
* Component ID: `5214` (Required: 1)
* Component ID: `5215` (Required: 1)
* Component ID: `5216` (Required: 1)
* Component ID: `5217` (Required: 1)
* Component ID: `5218` (Required: 1)
* Component ID: `5219` (Required: 1)
* Component ID: `5220` (Required: 1)
* Component ID: `5221` (Required: 1)
* Component ID: `5222` (Required: 1)
* Component ID: `5223` (Required: 1)

## 7. API / Data Mapping
* API ID: `4800` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `security_audit_runtime`
* **Test Name**: `SecurityAuditScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Security Audit`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cto`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Security Audit`)
4. **click_sidebar_link** (Selector: `None`, Value: `Security Audit`)
5. **check_url** (Selector: `None`, Value: `/executive/security-audit`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
