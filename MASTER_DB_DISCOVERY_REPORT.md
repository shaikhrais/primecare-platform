# MASTER DB DISCOVERY REPORT

This report details the full schema audit and row counts of `.agents/governance/governance.db` to serve as the structural discovery for the AI agent screen generation run.

## 📊 Database Metrics & Table Sizes

| Table Name | Row Count | Purpose & Category |
| :--- | :--- | :--- |
| **apps** | 35 | Master registry for application modules |
| **roles** | 64 | Platform security role definitions |
| **screens** | 948 | Master list of all platform screens |
| **role_screen_map** | 965 | Authorizations linking roles to screens |
| **ui_components** | 8671 | Master registry of reusable UI components |
| **screen_component_map** | 8663 | Mapped component usage per screen |
| **api_registry** | 1249 | Master backend API endpoint definitions |
| **screen_api_map** | 1266 | Mapping of endpoints required by each screen |
| **screen_requirements** | 948 | Product requirements & user stories per screen |
| **screen_required_elements** | 6484 | UI element presence verification targets |
| **screen_sections** | 4240 | Sub-screen section structural planning |
| **screen_section_elements** | 7128 | Interactive elements inside screen sections |
| **screen_implementation_blueprints**| 948 | Developer blueprint instructions |
| **section_function_descriptions** | 4240 | Purpose descriptions of screen sections |
| **element_function_descriptions** | 7128 | Purpose descriptions of section elements |
| **button_action_definitions** | 1760 | Handlers & target APIs for section buttons |
| **screen_test_definitions** | 948 | Dynamically generated Cypress E2E tests |
| **screen_test_steps** | 13274 | Action steps executed inside each E2E test |
| **screen_implementation_tasks** | 12324 | Generated sub-tasks for screen completion |
| **screen_issues** | 1125 | Issues tracked for failing screens |
| **api_endpoints** | 1146 | Low-level technical API path details |
| **cypress_results** | 1895 | Historical Cypress E2E execution logs |

---

## 🔗 Key Database Relationships

1. **Screen Authorization:** `role_screen_map.screen_id` references `screens.id`, and `role_screen_map.role_id` references `roles.id`.
2. **Section Layout Hierarchy:** `screen_sections.screen_id` references `screens.id`.
3. **Element Layout Hierarchy:** `screen_section_elements.section_id` references `screen_sections.id`, and `screen_section_elements.screen_id` references `screens.id`.
4. **Behavior Mappings:** 
   - `button_action_definitions.element_id` references `screen_section_elements.id`.
   - `element_function_descriptions.element_id` references `screen_section_elements.id`.
   - `section_function_descriptions.section_id` references `screen_sections.id`.
5. **E2E Test Steps Map:** `screen_test_steps.test_definition_id` references `screen_test_definitions.id`, which in turn references `screens.id`.

---

## 🔍 Missing or Empty Critical Tables

The following tables are currently empty (`0` rows):
- **sidebar_items:** (Note: Sidebar items are derived dynamically in the running Flutter app from the `PlatformScreenRegistry` and verified in Cypress using `role_screen_map` mappings).
- **api_request_schemas / api_response_schemas:** Request/response schemas are instead stored inside the JSON columns of `api_usage_blueprints` and `api_registry`.
- **manual_verification_checks:** All verifications are automated via Cypress E2E specs.

Discovery complete! The database has a consistent and highly comprehensive relational structure.
