# PrimeCare Governance Development Lifecycle

This document defines the mandatory architectural workflow for adding new features, screens, and data logic to the PrimeCare platform. Compliance is enforced programmatically.

---

## 1. The "Four-Pillar" Workflow
Every new screen or major code change must involve these four systems in order. Bypassing any step will trigger a **Governance Violation** in the UI.

### Pillar 1: Registry Definition
*   **Location**: `.agents/governance/page_inventory.yaml`
*   **Action**: Define the route name, role permissions, and the **Primary Title Key**.
*   **Rule**: Titles must be written as keys (e.g., `clinical.patient_intake.title`), never as raw text.

### Pillar 2: Architectural Layout (Blueprints)
*   **Location**: `packages/factory_system/primecare_ui/lib/src/registry/offices/`
*   **Action**: Map the route to a `PrimeCareScreenConfiguration`. 
*   **System Involved**: `UniversalScreenEngine`.
*   **Constraint**: All `componentLabels` must be localized keys.

### Pillar 3: Data Hydration (Adapters)
*   **Location**: `packages/primecare_adapters/`
*   **Action**: Ensure the `ViewModel` uses `LocaleKeys` for all dynamic text (KPI titles, labels, button text).
*   **System Involved**: `primecare_adapters`.

### Pillar 4: Smart Sync (i18n)
*   **Action**: Run `python apps/primecare_corporate/assets/translations/gen_translations.py`.
*   **Result**: Automatically populates `en.json` and `fr.json` and regenerates `LocaleKeys.dart`.

---

## 2. Verification System (The Guardrail)

To ensure high performance, we use an **Incremental Verification Engine**.

### How it works:
1.  **Scan**: The `lint_loose_text.py` script scans for hardcoded `Text('')` or `title: ''`.
2.  **Cache**: A `.lint_cache` file stores the MD5 hash of every "Clean" file.
3.  **Delta Rule**: If a file's hash matches the cache, it is skipped. Only new/changed code is verified.
4.  **Enforcement**: 
    - **Development**: Violations appear as red banners in the UI.
    - **Commit**: The Pre-Commit Hook blocks the push if any new "Loose Text" is found.

---

## 3. Converting Existing Code (Migration)

To convert the remaining "Loose Text" from older parts of the system:
1.  **Identify**: Run `python .agents/governance/lint_loose_text.py --full-scan`.
2.  **Register**: Move identified raw text into `page_inventory.yaml`.
3.  **Sync**: Run the translation engine.
4.  **Replace**: Update the code to use `LocaleKeys.[key].tr()`.

---

## 4. Platform Skill Integration
This system is not just for localization; it is a **Development Skill**.
- **Aura HUD Compliance**: New code must use the Aura HUD for telemetry.
- **Blueprint Compliance**: Screens must follow the structural blueprints defined in the Registry.
- **Factory Compliance**: All UI must be rendered via the `UniversalScreenEngine` to ensure global updates (like theme changes or font scaling) work instantly across all 251 screens.
