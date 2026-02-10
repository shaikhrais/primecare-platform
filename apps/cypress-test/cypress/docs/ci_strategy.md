# 🛡️ CI PIPELINE SETUP STRATEGY

## 🎯 OVERVIEW
The PrimeCare automation suite is designed for a three-layer pipeline strategy to balance speed and coverage.

| Layer | Trigger | Purpose | Tags |
| :--- | :--- | :--- | :--- |
| **🔹 Smoke** | Every PR / Merge | Immediate Protection | `@smoke`, `@auth` |
| **🔹 Security** | Nightly (2 AM) | RBAC & Contracts | `@security`, `@contract` |
| **🔹 Regression**| Weekly / Pre-Release| Deep Coverage | `@regression` |

---

## 1️⃣ PR PIPELINE (FAST GATE)
**Target: 3-5 minutes.**
Runs on every PR to ensure the application is "safe to merge".

### Command
```bash
npx cypress run --env grepTags="@smoke+@auth"
```

---

## 2️⃣ NIGHTLY SECURITY & CONTRACTS
Runs daily to catch permission regressions or UI contract breaks.

### Command
```bash
npx cypress run --env grepTags="@security,@contract"
```

---

## 3️⃣ WEEKLY FULL REGRESSION
Runs weekly to check edge cases, error states, and full CRUD workflows.

### Command
```bash
npx cypress run --env grepTags="@regression"
```

---

## 🧠 PERFORMANCE & STABILITY RULES

### ✅ Speed Optimizations
- **API Login**: Use `cy.request()` for login to bypass the UI where possible.
- **Session Caching**: Use `cy.session()` to persist authentication across specs.
- **Stubbing**: Use `cy.intercept()` with fixtures for slow dashboard endpoints.
- **Video**: Disabled for PR runs (`video: false`) to save CI resources.

### ✅ CI Parallelization
Tests are grouped by functional areas in `e2e/` and run across multiple parallel containers in GitHub Actions or similar.

### ✅ Flakiness Prevention
- **Selectors**: Strict adherence to `data-cy`.
- **Waits**: Zero `cy.wait(N)` (static sleeps). Use `cy.intercept()` aliases for network sync.
- **Isolation**: Every test clears local storage and cookies to ensure independence.

---

## 📊 REPORTING
Reports are generated using `mochawesome` in HTML and JSON formats, with attachments for failure screenshots and videos (nightly only).
Reports are located in `cypress/reports`.
