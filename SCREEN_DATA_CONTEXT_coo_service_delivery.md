# SCREEN DATA CONTEXT: coo_service_delivery

Below are the database records from `governance.db` used to configure and build the **Guest - CooServiceDeliveryScreen** screen.

---

## 1. Screen Record
* **ID**: `733`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `coo_service_delivery`
* **Screen Name**: `CooServiceDeliveryScreen`
* **Route Path**: `/offices/corporate/roles/coo/service-delivery`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/coo_service_delivery_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to coo service delivery.`
* **User Story**: `As a Guest, I want to access the Coo Service Delivery within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Coo Service Delivery`
* **Acceptance Criteria**:
- The Coo Service Delivery route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_service_delivery-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_service_delivery-title` (Type: header, Required: 1)
* **primary_content** -> `coo_service_delivery-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7021` (Required: 1)
* Component ID: `7022` (Required: 1)
* Component ID: `7023` (Required: 1)
* Component ID: `7024` (Required: 1)
* Component ID: `7025` (Required: 1)
* Component ID: `7026` (Required: 1)
* Component ID: `7027` (Required: 1)

## 7. API / Data Mapping
* API ID: `5115` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_service_delivery_runtime`
* **Test Name**: `Coo Service Delivery Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Coo Service Delivery`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/coo/service-delivery`)
3. **should_be_visible** (Selector: `coo_service_delivery-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_service_delivery-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_service_delivery-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
