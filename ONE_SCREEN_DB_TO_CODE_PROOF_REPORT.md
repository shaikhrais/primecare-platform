# One Screen DB-to-Code Proof Report

This report demonstrates that the metadata planning layer stored in `governance.db` successfully drives the generation, compilation, and E2E verification of a modular, section-based screen layout.

## Mapped Artifacts for Screen: PSW Dashboard (`psw_dashboard`)

### 1. Main Screen Coordinator File
- **Path:** [psw_dashboard_screen.dart](file:///c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/primecare_ui/lib/src/screens/psw/psw_dashboard/psw_dashboard_screen.dart)
- **Lines of Code:** 109 lines (Fully conforms to `< 150 lines` layout limit)
- **Role:** Main coordinator scaffold arranging sections using `ResponsiveSplitDashboard`.

### 2. Section Files
All section widgets are stored in their planned directories:
- **Header:** [psw_dashboard_header_section.dart](file:///c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/primecare_ui/lib/src/screens/psw/psw_dashboard/sections/psw_dashboard_header_section.dart) (16 lines)
- **Summary Cards:** [psw_dashboard_summary_section.dart](file:///c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/primecare_ui/lib/src/screens/psw/psw_dashboard/sections/psw_dashboard_summary_section.dart) (48 lines)
- **Interactive Actions:** [psw_dashboard_actions_section.dart](file:///c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/primecare_ui/lib/src/screens/psw/psw_dashboard/sections/psw_dashboard_actions_section.dart) (197 lines)
- **Data List Registry:** [psw_dashboard_data_list_section.dart](file:///c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/primecare_ui/lib/src/screens/psw/psw_dashboard/sections/psw_dashboard_data_list_section.dart) (68 lines)

### 3. API / Mock Service Controller
- **Path:** [psw_dashboard_controller.dart](file:///c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/primecare_ui/lib/src/screens/psw/psw_dashboard/psw_dashboard_controller.dart)
- **Role:** Implements Riverpod Notifier state bindings, loading animations, error state simulations, and mock data loading.

### 4. Route and Sidebar Wiring
- **Route Registry:** Wired `'SCREEN_PSW_DASHBOARD': const PswDashboardScreen()` in [screen_registry.dart](file:///c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/primecare_ui/lib/src/registry/screen_registry.dart).
- **Sidebar Integration:** Configured in `PlatformScreenRegistry` within `platform_screen_registry.dart` mapping `PSW_DASHBOARD` to the human-readable label **"Care Dashboard"** and the route path `/roles/psw/dashboard`.

---

## E2E Cypress Verification

The Cypress suite was executed successfully using the dynamically generated test definition:

```bash
python tools/testing/run_psw_dashboard_test.py
```

### Verified Assertions Log:
- **Login Successful:** Cypress authenticated via Cloudflare login with role `psw` and verified redirect from `/login`.
- **Sidebar Visible:** The left sidebar rendered successfully.
- **Sidebar Link Mapped:** Cypress confirmed "Care Dashboard" exists in the list of sidebar navigation options.
- **Route Loads:** Visited `/offices/clinical/roles/psw/dashboard` and successfully landed on the screen without console errors.
- **Sections Mapped:** Header, summary metrics, action cards, and assigned clients panels matched and verified in DOM.
- **Interactive Button Click:** Cypress clicked simulated shift buttons, executing underlying Riverpod controller state mutations.
- **Screenshot Captured:** Successfully saved visual proof of the mounting screen:

![PSW Dashboard Verification Proof](file:///C:/Users/Admin2/.gemini/antigravity-ide/brain/26b1218b-e518-4477-8a4e-2789a840acc1/psw_dashboard.png)

## Verification Status: SUCCESS
All database-driven E2E mounting and action steps passed successfully!
