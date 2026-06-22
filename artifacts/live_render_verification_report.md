# 🩺 Platform-Wide Live Render Visual Verification Audit Report

Generated at: **2026-06-21 13:15:39**
Test Run ID: **1**

## 📊 Platform Health Summary Dashboard

- **Global Verification Status**: 🟩 **ALL PORTALS OPERATIONAL**
- **Total Portals Checked**: **10**
- **Successfully Rendered**: **10 / 10**
- **Bootstrap Errors Detected**: **0**
- **Cumulative Verification Duration**: **113.79 seconds**

---

## 🛠️ Verification Methodology & Audit Process
To solve the issue of 'blind assertions' regarding application health, we implemented an autonomous Playwright verification pipeline:
1. **Headless Browser Bootstrap**: Spawns a Chromium instance using Playwright, simulating a standard desktop browser viewport (1440x900).
2. **Flutter Initialization Timeout**: Navigates to each portal's login router (`/login`) and holds execution for 10 seconds to allow the compiled WebAssembly/JS engine to fully mount semantics nodes.
3. **DOM Content & Structure Scan**: Evaluates the live page to verify that:
   - The body is not a blank screen (`innerHTML` content length > 100).
   - Flutter view canvas layers or semantics widgets (`<flt-glass-pane>`, `<flt-semantics>`) are injected.
   - The resilient `AppErrorBoundary` self-healing boundary (`'MECHANICAL FIX IN PROGRESS'`) has not been triggered.
4. **Active Console Telemetry Interceptor**: Catches and logs all unhandled Javascript exceptions and boot crashes via `page.on('pageerror')` and `page.on('console')` hooks.
5. **Visual Evidence Logging**: Captures a visual snapshot of the rendered state, saving it to the artifacts directory as a PNG.
6. **Governance Registry Syncreference**: Automatically records the run, timing data, errors, and files into the SQLite database registry.

---

## 📋 Granular Portal Verification Metrics

| Portal Code | Cloudflare URL | Render Status | Bootstrap (ms) | Active DOM Elements | Error Details |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `primecare_auth` | [https://primecare-auth.pages.dev/login](https://primecare-auth.pages.dev/login) | **✅ Passed** | 10894 | 46 | None |
| `primecare_governance` | [https://primecare-governance.pages.dev/login](https://primecare-governance.pages.dev/login) | **✅ Passed** | 13104 | 68 | None |
| `primecare_corporate` | [https://primecare-corporate.pages.dev/login](https://primecare-corporate.pages.dev/login) | **✅ Passed** | 11287 | 46 | None |
| `primecare_franchise` | [https://primecare-franchise.pages.dev/login](https://primecare-franchise.pages.dev/login) | **✅ Passed** | 11110 | 46 | None |
| `primecare_clinic` | [https://primecare-clinic.pages.dev/login](https://primecare-clinic.pages.dev/login) | **✅ Passed** | 13011 | 67 | None |
| `primecare_client` | [https://primecare-client.pages.dev/login](https://primecare-client.pages.dev/login) | **✅ Passed** | 10852 | 46 | None |
| `primecare_business_development` | [https://primecare-business-development.pages.dev/login](https://primecare-business-development.pages.dev/login) | **✅ Passed** | 11077 | 46 | None |
| `primecare_marketing` | [https://primecare-marketing.pages.dev/login](https://primecare-marketing.pages.dev/login) | **✅ Passed** | 10770 | 46 | None |
| `primecare_support` | [https://primecare-support.pages.dev/login](https://primecare-support.pages.dev/login) | **✅ Passed** | 11244 | 46 | None |
| `primecare_enterprise_blueprint` | [https://primecare-enterprise-blueprint.pages.dev/login](https://primecare-enterprise-blueprint.pages.dev/login) | **✅ Passed** | 10443 | 40 | None |

---

## 📸 Visual Verification Carousel & Console Logs
The visual evidence captured during this audit run is saved directly in the artifacts registry.

````carousel
<img src="file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/artifacts/live_verification_primecare_auth.png" alt="Portal: primecare_auth" width="100%" />
<!-- slide -->
<img src="file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/artifacts/live_verification_primecare_governance.png" alt="Portal: primecare_governance" width="100%" />
<!-- slide -->
<img src="file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/artifacts/live_verification_primecare_corporate.png" alt="Portal: primecare_corporate" width="100%" />
<!-- slide -->
<img src="file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/artifacts/live_verification_primecare_franchise.png" alt="Portal: primecare_franchise" width="100%" />
<!-- slide -->
<img src="file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/artifacts/live_verification_primecare_clinic.png" alt="Portal: primecare_clinic" width="100%" />
<!-- slide -->
<img src="file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/artifacts/live_verification_primecare_client.png" alt="Portal: primecare_client" width="100%" />
<!-- slide -->
<img src="file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/artifacts/live_verification_primecare_business_development.png" alt="Portal: primecare_business_development" width="100%" />
<!-- slide -->
<img src="file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/artifacts/live_verification_primecare_marketing.png" alt="Portal: primecare_marketing" width="100%" />
<!-- slide -->
<img src="file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/artifacts/live_verification_primecare_support.png" alt="Portal: primecare_support" width="100%" />
<!-- slide -->
<img src="file:///C:/Users/Admin2/Documents/GitHub/primecare-platform/artifacts/live_verification_primecare_enterprise_blueprint.png" alt="Portal: primecare_enterprise_blueprint" width="100%" />
````

---

## 🔬 Verification Logs & SQLite Governance Database Schema Input
This entire verification run has been logged into the `governance.db` SQLite database:
- **Run Table**: `test_runs` (ID: `1`) storing duration, timestamp, and health JSON.
- **Results Table**: `test_results` linking screenshots, browser console logs, and render outcome details.
- **Reports Table**: `governance_reports` storing this Markdown document for local audit compliance.