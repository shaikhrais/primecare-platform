# PrimeCare Architectural Governance Engine

This directory contains the high-fidelity governance and automated remediation platform for PrimeCare. It enables real-time auditing of the platform's architectural integrity, security compliance, and production readiness.

## Core Pillars

### 1. High-Fidelity Auditing
The engine utilizes a modular suite of audit services to scan every screen registered in the `ScreenRegistry`.
- **SecurityAuditService**: Enforces PHI protection, RBAC integrity, and sensitive data guards.
- **RouteAuditService**: Detects navigation collisions and deep-link inconsistencies.
- **RegistryIntegrityService**: Validates the structural consistency of the registry manifest.
- **ProductionReadinessService**: Scores screens against the "Golden Path" for deployment.

### 2. Automated Remediation
The `RegistryPatchEngine` enables one-click fixes for common architectural drifts directly from the dashboard. It performs targeted line-replacement to reconcile registry state with platform requirements.

### 3. Visual Telemetry (Aura Intelligence)
- **Master Score**: A weighted health score (30% Render, 20% A11y, 20% Perf, 30% Testing).
- **Domain Breakdown**: Visualizing compliance across 7 key architectural domains.
- **KPI Grid**: Real-time tracking of LOC, Subsystems, and UI Coverage.

## Implementation Guide

To add a new audit rule:
1. Create a new service in `lib/governance/services/`.
2. Implement a `static List<GovernanceIssue> scan(ScreenMetadata s)` method.
3. Register the service in `ScreenGovernanceReporter.scan()`.

## Dashboards
- **GovernanceHUD**: The flagship "Aura Intelligence" overlay for live platform health.
- **GovernanceDashboard**: Detailed audit log with filtering, remediation, and export capabilities.

---
*Built for Zero-Error architectural oversight.*
