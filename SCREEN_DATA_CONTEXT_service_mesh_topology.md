# SCREEN DATA CONTEXT: service_mesh_topology

Below are the database records from `governance.db` used to configure and build the **Guest - ServiceMeshTopologyScreen** screen.

---

## 1. Screen Record
* **ID**: `931`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `service_mesh_topology`
* **Screen Name**: `ServiceMeshTopologyScreen`
* **Route Path**: `/generated/service-mesh-topology`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/service_mesh_topology.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to service mesh topology.`
* **User Story**: `As a Guest, I want to access the Service Mesh Topology within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Service Mesh Topology`
* **Acceptance Criteria**:
- The Service Mesh Topology route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `service_mesh_topology-screen` (Type: layout, Required: 1)
* **page_title** -> `service_mesh_topology-title` (Type: header, Required: 1)
* **primary_content** -> `service_mesh_topology-content` (Type: layout, Required: 1)
* **service_mesh_topology_iconbutton_button_1** -> `service_mesh_topology_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8104` (Required: 1)
* Component ID: `8105` (Required: 1)
* Component ID: `8106` (Required: 1)
* Component ID: `8107` (Required: 1)
* Component ID: `8108` (Required: 1)
* Component ID: `8109` (Required: 1)
* Component ID: `8110` (Required: 1)

## 7. API / Data Mapping
* API ID: `5363` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `service_mesh_topology_runtime`
* **Test Name**: `Service Mesh Topology Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Service Mesh Topology`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Service Mesh Topology`)
4. **click_sidebar_link** (Selector: `None`, Value: `Service Mesh Topology`)
5. **check_url** (Selector: `None`, Value: `/generated/service-mesh-topology`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
