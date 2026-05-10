# PrimeCare Platform Organization & Architectural Characteristics

This document outlines the unified monorepo structure of the PrimeCare platform, categorizing projects by their architectural roles and characteristics.

## 1. Application Layer (`/apps`)
Highly specialized Flutter applications representing distinct business portals. All apps follow the **Registry-Driven UX** pattern.

| Project | Role | Characteristics |
| :--- | :--- | :--- |
| `primecare_governance` | **Control Plane** | Orchestrates audit, remediation, and platform parity. |
| `primecare_corporate` | **Strategic Oversight** | CEO/Executive dashboards, enterprise-wide reporting. |
| `primecare_clinic` | **Clinical Operations** | Resource management, patient intake, clinic flow. |
| `primecare_client` | **Patient Portal** | Self-service, appointment booking, health records. |
| `primecare_franchise` | **Franchise Management** | Multi-unit performance tracking and billing. |
| `primecare_marketing` | **Growth Engine** | Lead capture, conversion analytics, CRM integration. |
| `primecare_support` | **Operational Support** | Ticketing, technical assistance, system status. |
| `primecare_business_dev`| **Expansion** | Lead generation and business growth tools. |
| `primecare_enterprise_blueprint` | **System Seed** | Foundational templates and architectural skeletons. |

## 2. Service Layer (`/services`)
Dart-based microservices using the **Shelf** framework. Standardized on AOT compilation for Cloudflare Workers / Containerized deployment.

| Service | Responsibility | Governance |
| :--- | :--- | :--- |
| `governance_api` | Core Platform Audit | Enforces 4K Standard and Registry Parity. |
| `api_gateway` | Request Orchestration | Authentication, Rate Limiting, Service Mesh. |
| `auth_api` | Identity Management | RBAC, Token validation, Session governance. |
| `billing_api` | Financial Ledger | Double-entry accounting, Tax compliance. |
| `clinical_api` | Medical Data | HIPAA/PHI compliant patient record management. |
| `compliance_api` | Regulatory Check | Real-time audit trails and safety checks. |
| `notification_api` | Event Dispatch | Multi-channel alerts (SMS, Email, Push). |

## 3. Shared Layer (`/packages`)
Foundational logic and UI components that ensure cross-subsystem consistency.

| Package | Purpose | Characteristics |
| :--- | :--- | :--- |
| `flutter_core` | **The Brain** | Shared models, governance types, and base logic. |
| `primecare_ui` | **Visual Standard** | High-fidelity Atomic Design components (4K optimized). |
| `database_client` | **Persistence** | Type-safe database adapters (Prisma-style in Dart). |

## 4. Automation & Governance (`/scripts`, `/tools`)
Engines that maintain platform health and automate repetitive tasks.

| Tooling | Function |
| :--- | :--- |
| `Governance Engine` | Automated AST-based remediation of architectural drift. |
| `Build Orchestrator` | Parallel build and deployment of 9+ apps and 10+ services. |
| `Feature Tracker` | Real-time mapping of screen intents to implementation status. |

---
*Last Updated: 2026-05-10*
*Status: 100% Migrated to Full-Stack Dart/Flutter Ecosystem*
