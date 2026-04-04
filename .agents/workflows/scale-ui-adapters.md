---
description: How to scale the UI Data Binding Adapter Architecture to new screens in PrimeCare
---

# PrimeCare Adapter Scaling Workflow

This workflow is utilized by AI Coding Agents to migrate an existing `Stitch-generated` UI or raw JSON endpoint into the robust **Centralized Screen Data Binding Adapter** architecture natively in Flutter/Dart.

## 1. Domain & Data Scaffold
Identify the feature name (e.g., `ClientProfile`).

// turbo
```powershell
New-Item -ItemType Directory -Force apps/primecare_v4/lib/features/$featureName/domain/models;
New-Item -ItemType Directory -Force apps/primecare_v4/lib/features/$featureName/data/dtos;
New-Item -ItemType Directory -Force apps/primecare_v4/lib/features/$featureName/data/mappers;
New-Item -ItemType Directory -Force apps/primecare_v4/lib/features/$featureName/data/adapters;
New-Item -ItemType Directory -Force apps/primecare_v4/lib/features/$featureName/data/repositories;
```

## 2. Generate the ViewModel (Domain Layer)
Create `lib/features/$featureName/domain/models/${featureName}_view_model.dart`.
- Define ONLY the strict properties the Flutter UI needs to render.
- Do NOT include any API-specific metadata (e.g., raw JSON maps, HTTP status codes).

## 3. Generate the DTO (Data Layer)
Create `lib/features/$featureName/data/dtos/${featureName}_dto.dart`.
- Define the `factory fromJson(Map<String, dynamic> json)` map.
- This represents exactly what the backend API payload outputs.

## 4. Generate the Mapper (Mapping Layer)
Create `lib/features/$featureName/data/mappers/${featureName}_mapper.dart`.
- Create `static ViewModel fromMock(Map<String, dynamic> mock)`.
- Create `static ViewModel fromApi(DTO dto)`.
- Reconcile naming discrepancies (e.g., `visitsCount` from mock -> `dto.todayVisits`).

## 5. Generate the Resilient Adapter (Adapter Layer)
Create `lib/features/$featureName/data/adapters/${featureName}_adapter.dart`.
- Import `DataSourceConfig` from `core/config/data_source_mode.dart`.
- Create an async `getData()` method.
- **CRITICAL**: Use a `try/catch` block for API mode, and if it fails AND `DataSourceConfig.currentMode == DataSourceType.hybrid`, fallback and return the Mock Mapper parsing.

## 6. Update Providers & Registry
- Register the new Adapter in `lib/providers/adapter_providers.dart` using `FutureProvider` or a `Notifier`.
- Register the semantic mapping to `lib/core/registry/screen_data_registry.dart`.

## 7. Refactor the UI Fragment
- Locate the target `StatelessWidget`/`ConsumerWidget` in `apps/primecare_v4/lib/components/`.
- Replace unstructured references to `dynamicPageProvider` with your newly created Adapter provider instance.
- Run `dart analyze` to ensure the strict `ViewModel` parameters typecheck successfully.
