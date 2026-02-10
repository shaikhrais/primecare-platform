# 🚀 PHASE 1 AUTOMATION ROADMAP

## 🎯 GOAL
Protect production from breaking by ensuring core revenue and security flows never fail. This phase builds the foundation for a scalable automation suite.

---

## 🏆 PRIORITY STRATEGY (RISK-BASED)
1. 🔴 **Revenue & Security Impact** (Highest)
2. 🔴 **High Traffic & Core Workflows**
3. 🟡 **Admin Operational Stability**
4. 🟢 **Nice-to-have Features** (Future phases)

---

## 🥇 TIER 1 – CORE STABILITY (MUST AUTOMATE FIRST)

### 1️⃣ Application Smoke Layer (`@smoke`)
- All marketing and admin routes load
- No white screens or JS exceptions
- Unknown routes handle 404 gracefully

### 2️⃣ Authentication Core (`@smoke @security`)
- Success login/logout for all roles (Staff, PSW, Manager, Client)
- Invalid credential handling
- Guest access blocking

### 3️⃣ Role-Based Access Matrix (`@security`)
- Verification of protected routes (`/dashboard`, `/users`, `/schedule`, `/earnings`, `/shifts`, `/profile`)
- Privilege escalation prevention

### 4️⃣ Dashboard & Schedule Contracts (`@contract`)
- Stats card and quick action rendering
- Calendar grid visibility and filters

### 5️⃣ PSW Portal Essentials (`@portal @smoke`)
- Shifts, Earnings, and Profile load verification

---

## 🥈 TIER 2 – OPERATIONAL FLOWS (WEEKS 3-4)

### 6️⃣ Management Modules
- **Users**: List render, search, and metadata verification.
- **Leads (CRM)**: List render, creation flow, and status badges.
- **Timesheets**: Approval/Rejection status rendering.
- **Visits**: Detail page load and note submission.

---

## 🟡 SCOPE EXCLUSIONS (PHASE 2 & 3)
- Content Manager deep CRUD
- Analytical Reports
- Billing/Invoice exports
- Visual Regression & Performance deep-dives
- Accessibility full-suite (A11y)

---

## 🏗️ CYPRESS STRUCTURE
```text
cypress/e2e/
  00_smoke/        # PR Triggered
  10_auth/         # PR Triggered
  20_security/     # Nightly
  30_dashboard/    # Weekly
  40_schedule/     # Weekly
  50_psw_portal/   # PR Triggered
```

---

## 📊 ESTIMATED COVERAGE AFTER PHASE 1
| Module | Coverage % |
| :--- | :--- |
| **Auth & Routing** | 100% |
| **RBAC Security** | 90% |
| **Dashboards** | 80% |
| **Worker Portal** | 70% |
| **Scheduling** | 70% |
| **CRM/Leads** | 40% |
| **Reporting** | 0% (Phase 2) |
