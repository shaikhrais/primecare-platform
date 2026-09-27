# SCREEN DATA CONTEXT: compliance_manager_document_expiry

Below are the database records from `governance.db` used to configure and build the **Guest - ComplianceManagerDocumentExpiryScreen** screen.

---

## 1. Screen Record
* **ID**: `740`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `compliance_manager_document_expiry`
* **Screen Name**: `ComplianceManagerDocumentExpiryScreen`
* **Route Path**: `/generated/compliance-manager-document-expiry`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/compliance_manager_document_expiry_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to compliance manager document expiry.`
* **User Story**: `As a Guest, I want to access the Compliance Manager Document Expiry within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Compliance Manager Document Expiry`
* **Acceptance Criteria**:
- The Compliance Manager Document Expiry route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_manager_document_expiry-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_manager_document_expiry-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_manager_document_expiry-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7060` (Required: 1)
* Component ID: `7061` (Required: 1)
* Component ID: `7062` (Required: 1)
* Component ID: `7063` (Required: 1)
* Component ID: `7064` (Required: 1)

## 7. API / Data Mapping
* API ID: `5124` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_manager_document_expiry_runtime`
* **Test Name**: `Compliance Manager Document Expiry Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Manager Document Expiry`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/compliance-manager-document-expiry`)
3. **should_be_visible** (Selector: `compliance_manager_document_expiry-screen`, Value: `None`)
4. **should_be_visible** (Selector: `compliance_manager_document_expiry-title`, Value: `None`)
5. **should_be_visible** (Selector: `compliance_manager_document_expiry-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
