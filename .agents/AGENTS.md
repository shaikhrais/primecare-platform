# 1. Architecture Principles

```text
Single Source of Truth

governance.db is the ONLY source of truth.

AI must never invent

• screens
• sections
• elements
• APIs
• routes
• permissions
• sidebar items
• dashboard widgets

Everything must exist in governance.db before implementation.
```

---

# 2. Database First Development

```text
Business Requirement
↓

Database Design

↓

Data Entry

↓

Validation

↓

Architecture Review

↓

Code Generation

↓

Testing

↓

Release
```

---

# 3. No Business Logic in UI

```text
Screen files are presentation only.

No

business rules

permission logic

SQL

API URLs

hardcoded roles

workflow logic

inside UI.

UI only renders data.
```

---

# 4. Folder Standards

Every folder has one responsibility.

```text
apps/

auth/

shell/

dashboard/

screens/

sections/

elements/

widgets/

routes/

controllers/

services/

repositories/

models/

entities/

apis/

theme/

localization/

state/

tests/

documentation/
```

No mixed responsibilities.

---

# 5. PrimeCare UI Rules

Use only approved PrimeCare UI components.

```text
PrimeShell

PrimeSidebar

PrimeTopbar

PrimeDashboard

PrimeSection

PrimeCard

PrimeButton

PrimeIconButton

PrimeText

PrimeLabel

PrimeTextField

PrimeDropdown

PrimeCheckbox

PrimeRadio

PrimeTable

PrimeDialog

PrimeLoading

PrimeEmptyState

PrimeErrorState

PrimeNotification

PrimeToast
```

Every UI element must map to:

```text
primecare_ui_component_registry
```

---

# 6. Accessibility Standards

Require WCAG 2.2 AA.

Every component must support:

```text
Keyboard navigation

Screen readers

ARIA labels

Focus management

Tab order

Color contrast

Accessible error messages

Responsive scaling
```

---

# 7. Security Standards

Implement:

```text
OWASP ASVS

OWASP Top 10

Least Privilege

Zero Trust

Secure Headers

JWT/OAuth validation

CSRF protection

XSS prevention

SQL Injection prevention

Audit Logging
```

---

# 8. Performance Standards

Targets:

```text
Screen render

Dashboard load

API response

Search response

Sidebar render

Lazy loading

Virtual scrolling

Caching

Background synchronization
```

---

# 9. API Standards

Every endpoint must define:

```text
Request schema

Response schema

Validation

Authentication

Authorization

Permissions

Rate limits

Audit events

OpenAPI specification

Example payloads

Error responses

Version
```

---

# 10. Design Standards

Never hardcode:

```text
Colors

Typography

Spacing

Radius

Borders

Icons

Animations

Shadows

Breakpoints
```

Everything comes from:

```text
theme_design_tokens
```

---

# 11. Localization Standards

No hardcoded UI text.

Everything uses:

```text
resource_key

↓

language_resource_values
```

Support:

* Multiple languages
* RTL/LTR
* Date formats
* Number formats
* Currency
* Time zones
* Regional settings

---

# 12. Dashboard Standards

Every dashboard supports:

```text
Role default layout

↓

User custom layout

↓

JSON layout

↓

Optional XML import/export

↓

Widget registry

↓

Permissions

↓

API mapping

↓

Personal preferences
```

---

# 13. Coding Standards

Follow:

```text
SOLID

DRY

KISS

YAGNI

Clean Architecture

C4 Model

Feature-First Architecture

Dependency Injection

Repository Pattern

Factory Pattern where appropriate

Composition over inheritance
```

---

# 14. Documentation Standards

Every feature documents:

```text
Purpose

Business process

Workflow

Screens

Sections

Elements

APIs

Permissions

Validation rules

Test cases

Known issues

Dependencies

Owner
```

---

# 15. AI Quality Gates

AI must refuse implementation if any of these are missing:

```text
Business requirement

Role

Screen

Section

Element

API

Permission

Theme

Localization

Tests

Documentation
```

---

# 16. Code Generation Order

```text
Database

↓

Business Rules

↓

Theme

↓

Localization

↓

PrimeCare UI

↓

Routes

↓

AppShell

↓

Sidebar

↓

Topbar

↓

Dashboard

↓

Sections

↓

Elements

↓

State Management

↓

APIs

↓

Validation

↓

Testing

↓

Documentation
```

---

# 17. Review Gates

Every implementation requires:

```text
Architecture Review

Database Review

Security Review

Accessibility Review

Performance Review

Localization Review

API Review

Testing Review

Documentation Review
```

---

# 18. Enterprise Standards

Adopt recognized standards where applicable:

* Architecture: TOGAF concepts, C4 Model, Clean Architecture
* API: OpenAPI 3.1
* Accessibility: WCAG 2.2 AA
* Security: OWASP ASVS and OWASP Top 10
* Healthcare privacy: applicable regulations for deployment (such as PHIPA or HIPAA where relevant)
* Testing: Unit, Integration, API, End-to-End, Accessibility, Performance

---

# 19. AI Ethics & Engineering Rules

Every AI agent must:

```text
Never fabricate database records.

Never invent missing screens or APIs.

Never report success without evidence.

Never mark a screen complete because it compiles.

Never mark a screen complete unless:
- UI exists
- APIs are connected
- Permissions are enforced
- Navigation works
- Tests pass
- Accessibility is verified

Always flag:

Placeholder code

Mock implementations

TODOs

Dead code

Unused APIs

Broken navigation

Missing translations

Missing tests

Missing permissions

Preserve backward compatibility unless an approved migration exists.

All generated artifacts must be reproducible from governance.db.
```

---

# 20. Implementation Tag-Value Framework

```text
All generated entities must carry implementation tags.

No screen, section, element, button, API, or feature may be called complete unless its tag values prove completion.

Agents must update tag values honestly.

Never mark placeholder as implemented.

Never mark template_only as implemented.

Never mark API missing as connected.

Never mark Cypress failed as passed.

Cypress must validate data tag attributes before accepting screenshots.

Screenshot alone is not proof.

Tag values + Cypress + screenshot = proof.

If implementation changes, tags must change.
If logic is implemented, update tag value.
If API is connected, update tag value.
If button becomes functional, update tag value.
If Cypress passes, update tag value.
If human review approves, update tag value.
Production-ready requires all required tags to be ready.
```

---

# 21. Cypress Component Identification & data-cy Standards

Every rendered component that can be tested MUST expose a unique, stable `data-cy` attribute.

```text
Naming rules:
- Always use lowercase.
- Use kebab-case.
- Never use spaces.
- Never generate random IDs.
- Always derive from governance.db.
```

## Naming Examples
- Screen container: `data-cy="screen-client-profile"`
- Section container: `data-cy="section-medical-history"`
- Elements: `data-cy="element-allergy-table"`
- Buttons: `data-cy="save-visit-note-button"`, `data-cy="cancel-button"`
- Forms: `data-cy="visit-note-form"`
- Inputs: `data-cy="client-name-input"`
- Sidebar: `data-cy="app-sidebar"`, `data-cy="sidebar-group-clients"`, `data-cy="sidebar-item-client-list"`
- Topbar: `data-cy="app-topbar"`, `data-cy="topbar-search"`, `data-cy="topbar-logout"`
- Dialogs: `data-cy="delete-confirm-dialog"`, `data-cy="confirm-delete-button"`
- Loading: `data-cy="loading"`, `data-cy="loading-spinner"`
- Empty State: `data-cy="empty-state"`
- Error State: `data-cy="error-state"`
- API Components: `data-cy="api-status"`, `data-cy="api-loading"`, `data-cy="api-error"`

## Rule Exclusions & Enforcements
- Every reusable PrimeCare UI component must expose `dataCy` through constructor parameters.
- Cypress tests must interact with the application exclusively through `data-cy` selectors.
- CSS classes, text, or DOM hierarchy selectors are not allowed in testing.

---

# 22. Flutter Web Selenium Semantics Rules

This is a Flutter Web app. Do not use data-cy for Selenium because Flutter widgets do not render as normal HTML attributes.

Add Semantics labels to all testable widgets:
- login-email
- login-password
- login-submit
- topbar-logout-button

Then Selenium should locate elements using XPath with aria-label:
//*[@aria-label='login-email']

Also ensure Flutter Web semantics are enabled so aria-label elements appear in the DOM.



