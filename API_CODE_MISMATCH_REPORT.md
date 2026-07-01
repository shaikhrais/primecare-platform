# Screen API Code Implementation Mismatch Report

Total entries: 4

| ID | Screen Name | Screen Code | Role | App | Route Path | File Path | Problem Found | Exact Missing Item | Suggested Fix |
|---|---|---|---|---|---|---|---|---|---|
| 137 | SharedScreenStubs | `shared_stubs` | Dynamic Screen Viewer | PrimeCare UI Client | `/common/shared-stubs` | `packages/primecare_ui/lib/src/screens/common/shared_screen_stubs.dart` | Missing API client calls for: api_v1_shared_stubs_list_get | `api_v1_shared_stubs_list_get` | Import api_clients.dart and add Riverpod loading state handlers consuming the generated API clients |
| 619 | Success Profile | `success_profile` | Guest | Primecare Clinic | `/generated/success-profile` | `apps/primecare_auth/lib/main.dart` | Missing API client calls for: api_v1_success_profile_list_get | `api_v1_success_profile_list_get` | Import api_clients.dart and add Riverpod loading state handlers consuming the generated API clients |
| 819 | Dynamic | `dynamic` | Guest | Primecare Clinic | `/generated/dynamic` | `apps/primecare_governance/lib/core/ui/dynamic_screen_view.dart` | Missing API client calls for: api_v1_dynamic_list_get, api_v1_dynamic_create_post, api_v1_dynamic_update_patch | `api_v1_dynamic_list_get, api_v1_dynamic_create_post, api_v1_dynamic_update_patch` | Import api_clients.dart and add Riverpod loading state handlers consuming the generated API clients |
| 820 | Blueprint Sandbox | `blueprint_sandbox` | Guest | Primecare Clinic | `/generated/blueprint-sandbox` | `apps/primecare_governance/lib/core/ui/dynamic_screen_view.dart` | Missing API client calls for: api_v1_blueprint_sandbox_list_get, api_v1_blueprint_sandbox_create_post, api_v1_blueprint_sandbox_update_patch | `api_v1_blueprint_sandbox_list_get, api_v1_blueprint_sandbox_create_post, api_v1_blueprint_sandbox_update_patch` | Import api_clients.dart and add Riverpod loading state handlers consuming the generated API clients |
