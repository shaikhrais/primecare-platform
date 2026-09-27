# PrimeCare Governance: The 14 Audit Articles

The PrimeCare platform enforces structural integrity and production readiness through 14 standardized Audit Articles. These articles are automatically validated by the `AutomatedAuditEngine` and visualized in the `VerificationCenter`.

## 🛡️ Foundational Integrity (Articles 1-4)
- **Article 1: Screen Registry Mapping**
  - **Requirement**: Every UI screen must be registered in the `ScreenRegistry`.
  - **Check**: Verifies existence of metadata for the active route.
- **Article 2: Role-Based Access Control (RBAC)**
  - **Requirement**: Screens must define a `requiredRole`.
  - **Check**: Ensures metadata contains a valid platform role (e.g., 'System Administrator', 'PSW').
- **Article 3: Lifecycle Management**
  - **Requirement**: Features must have a defined `LifecycleStatus` (alpha, beta, production).
  - **Check**: Prevents non-production code from reaching restricted environments.
- **Article 4: Subsystem Ownership**
  - **Requirement**: Every screen must belong to a specific architectural subsystem (e.g., 'factory_system', 'aura_clinical').

## 🌍 Globalization & Accessibility (Articles 5-7)
- **Article 5: Localization Coverage (L10N)**
  - **Requirement**: `hasAllTranslations` must be true for production readiness.
  - **Check**: Validates that `translationKeys` are populated and present in the ARB files.
- **Article 6: Dynamic Text Scaling**
  - **Requirement**: UI must handle 200% text scaling without overflow.
  - **Check**: Layout Auditor verifies flexible/expanded usage in text-heavy components.
- **Article 7: RTL (Right-to-Left) Readiness**
  - **Requirement**: All layouts must use logical properties (padding-inline, etc.).

## 🎨 UI/UX Consistency (Articles 8-10)
- **Article 8: Layout Breakpoint Parity**
  - **Requirement**: Screens must define responsive behavior for Mobile, Tablet, and Desktop.
  - **Check**: Validates `LayoutAuditor` results for breakpoint coverage.
- **Article 9: Typography & Color Token Compliance**
  - **Requirement**: Zero usage of hardcoded hex values or raw font sizes.
  - **Check**: Ensures theme-driven styling via the PrimeCare Design System.
- **Article 10: Empty State Implementation**
  - **Requirement**: Every data-driven screen must implement an `EmptyState` view for missing data scenarios.

## 🔒 Security & Resilience (Articles 11-14)
- **Article 11: PHI & PII Protection (Security)**
  - **Requirement**: Screens displaying sensitive data must use `SecurityAuditor` masks or encrypted fields.
- **Article 12: Network Resilience (Resilience Patterns)**
  - **Requirement**: API-touching code must implement the platform's mandatory retry and timeout logic.
- **Article 13: QA & Automated Test Coverage**
  - **Requirement**: Core business logic must have >80% test coverage.
- **Article 14: Asset & Bundle Optimization**
  - **Requirement**: No duplicate assets; bundle size must remain within established limits for the environment.

---
*Note: This document serves as the "System Brain" for the AutomatedAuditEngine and is enforced by the factory-system governance layer.*
