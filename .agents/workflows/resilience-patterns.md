---
description: Mandatory resilience patterns for all API-touching code in PrimeCare. Follow this for every new service, provider, and screen.
---

# PrimeCare Resilience Standards

**Rule**: Every line of code that touches a network call, a provider, or the UI must follow these patterns. No exceptions. If you skip a pattern, the platform becomes fragile at scale.

---

## Quick Decision Tree

```
Writing new code? Ask yourself:

1. Does it make an API call?
   → YES: Use Result.guardFuture + passGate/failGate (Section 1)

2. Does it consume a Result from a service?
   → YES: Use result.fold() with positional params (Section 2)

3. Is it a new app entrypoint (main.dart)?
   → YES: Wrap with AppErrorBoundary.runGuarded (Section 3)

4. Does it store data in a growing list/buffer?
   → YES: Add a max capacity cap (Section 4)
```

---

## Section 1: Service Layer — `Result.guardFuture` Pattern

**Every** method in a service class that calls the API **must** use this exact pattern:

```dart
import 'package:primecare_core/primecare_core.dart';

class MyNewService {
  final Ref _ref;
  late final ApiClient _apiClient;
  late final ExecutionGateService _telemetry;

  MyNewService(this._ref) {
    _apiClient = _ref.read(apiClientProvider);
    _telemetry = _ref.read(executionGateProvider);
  }

  Future<Result<Map<String, dynamic>>> fetchSomething(String id) async {
    return Result.guardFuture<Map<String, dynamic>>(
      () async {
        final response = await _apiClient.get('/my-endpoint/$id');
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Fetched something successfully',
          metadata: {'endpoint': '/my-endpoint/$id'},
        );
        return response.data;
      },
      onError: (e, st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to fetch something',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': '/my-endpoint/$id'},
        );
        // Return a safe fallback — never throw from onError
        return <String, dynamic>{'error': e.toString(), 'fallback': true};
      },
    );
  }
}
```

### Rules:
- ✅ **Always** return `Future<Result<T>>`, never raw `Future<T>`
- ✅ **Always** call `passGate` inside the computation on success
- ✅ **Always** call `failGate` inside `onError` on failure
- ✅ **Always** provide a safe fallback value in `onError` (empty map, empty list, default model)
- ❌ **Never** use bare `try-catch` in a service method
- ❌ **Never** return `Future<T>` without `Result` wrapping from a service

---

## Section 2: Provider Layer — `fold()` Pattern

**Every** provider that consumes a `Result<T>` from a service **must** use `fold()` with **positional parameters**:

```dart
final myDataProvider = FutureProvider.family<MyModel, String>((ref, id) async {
  final service = MyNewService(ref);
  final result = await service.fetchSomething(id);

  return result.fold(
    (data) {
      // SUCCESS: Transform the raw data into your model
      return MyModel.fromJson(data);
    },
    (error) {
      // FAILURE: Return a safe fallback (from DataLogisticsHub or empty model)
      return MyModel.empty();
    },
  );
});
```

### Rules:
- ✅ `fold()` uses **positional** parameters: `fold(onSuccess, onFailure)`
- ❌ **Never** use named parameters: ~~`fold(onSuccess: ..., onFailure: ...)`~~
- ✅ **Always** handle both branches — never assume success
- ✅ Use `DataLogisticsHub` for rich fallback data when available
- ❌ **Never** call `.dataOrNull!` — prefer `fold()` for deterministic handling

---

## Section 3: App Entrypoint — `AppErrorBoundary` Pattern

**Every** `main.dart` file **must** use `AppErrorBoundary.runGuarded`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ... any pre-app setup (SharedPreferences, EasyLocalization, etc.)

  AppErrorBoundary.runGuarded(
    () => runApp(
      ProviderScope(child: const MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Drain any boundary-caught errors into telemetry
    AppErrorBoundary.drainToTelemetry(ref.read(executionGateProvider));
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(title: 'My App', routerConfig: router);
  }
}
```

### Rules:
- ✅ `WidgetsFlutterBinding.ensureInitialized()` **before** `AppErrorBoundary.runGuarded`
- ✅ `AppErrorBoundary.drainToTelemetry()` in the root widget's `build()`
- ❌ **Never** call `runApp()` without wrapping in `AppErrorBoundary.runGuarded`

---

## Section 4: Network Resilience — Built Into ApiClient

These are **already wired** into `ApiClient` and apply to all HTTP calls automatically:

| Layer | What It Does | Config |
|---|---|---|
| **Circuit Breaker** | Blocks requests when backend is unhealthy | 5 failures → 30s cooldown |
| **Auth Interceptor** | Attaches JWT from SharedPreferences | Auto on every request |
| **Telemetry Interceptor** | `passGate`/`failGate` on every request/response/error | Auto on every request |
| **Retry Interceptor** | Retries transient GET failures with exponential backoff | 2 retries, 500ms–8s, jitter |
| **Log Interceptor** | Debug logging of request/response bodies | Auto in debug mode |

**You do NOT need to add retry or circuit breaker logic in your services.** The interceptors handle it.

---

## Section 5: Telemetry — `ExecutionGateCategory` Selection

Choose the correct category when calling `passGate`/`failGate`:

| Category | When to Use |
|---|---|
| `auth` | Login, logout, token refresh, session restore |
| `domainApi` | Any business-logic API call (CRUD operations) |
| `network` | Raw HTTP-level events (auto-handled by ApiClient interceptor) |
| `metricsLayer` | Dashboard metrics assembly and hydration |
| `auraEngine` | Aura AI heartbeat and prediction engine |
| `aura` | Aura insight events and anomaly detection |
| `scheduler` | Appointment/staff/resource scheduling operations |
| `ui` | UI rendering, navigation transitions |
| `system` | App lifecycle, error boundary catches |
| `resource` | File uploads, asset management |
| `navigationLayer` | Route transitions, deep link resolution |

---

## Section 6: Fallback Data — `DataLogisticsHub`

When an API call fails, **never return null** and **never show an empty screen**. Use `DataLogisticsHub` for rich fallback data:

```dart
onError: (e, st) {
  _telemetry.failGate(...);
  // Return cached/blueprint data so the UI stays alive
  return DataLogisticsHub.getDashboardMetrics(role);
},
```

### Available fallback methods:
| Method | Returns |
|---|---|
| `getDashboardMetrics(role)` | KPIs, charts, activity for any role |
| `getClinicIntelligenceMetrics()` | Full clinical intelligence view model |
| `getAuraBlueprints(role)` | AI intelligence insights for a role |
| `getHorizonBlueprint()` | Staff, resources, appointments schedule |
| `getReportBlueprint(reportId)` | Report columns and row data |

---

## Section 7: Memory Safety

**Any in-memory buffer that grows over time must have a cap:**

```dart
// ✅ CORRECT — capped buffer
static const int _maxEntries = 500;

void addEntry(Entry entry) {
  _entries.add(entry);
  if (_entries.length > _maxEntries) {
    _entries.removeRange(0, _entries.length - _maxEntries);
  }
}

// ❌ WRONG — unbounded growth
void addEntry(Entry entry) {
  _entries.add(entry); // grows forever → OOM on long sessions
}
```

---

## Section 8: Connectivity Awareness

**Check connectivity before making API calls** to prevent 15s timeout waits when offline:

```dart
final myDataProvider = FutureProvider<MyModel>((ref) async {
  // Fast-fail if offline — don't waste 15s on a timeout
  final isOnline = ref.read(isOnlineProvider);
  if (!isOnline) {
    return MyModel.offline(); // or use DataLogisticsHub fallback
  }

  final service = MyService(ref);
  final result = await service.fetchData();
  return result.fold(
    (data) => MyModel.fromJson(data),
    (error) => MyModel.offline(),
  );
});
```

### Available providers:
| Provider | Type | Purpose |
|---|---|---|
| `connectivityServiceProvider` | `ConnectivityService` | Full service with stream subscription |
| `isOnlineProvider` | `bool` | Simple true/false check |

### Rules:
- ✅ Check `isOnlineProvider` before API calls in providers that load dashboard/metrics data
- ✅ Show an "Offline" indicator in the UI when `isOnlineProvider` is false
- ❌ **Never** let requests sit for 15s when you already know the device is offline

---

## Section 9: Provider TTL (Time-to-Live)

**Prevent stale data on long sessions** by auto-invalidating providers:

```dart
// One-shot TTL: re-fetches after 5 minutes
final myMetricsProvider = FutureProvider.autoDispose<MyModel>((ref) async {
  ProviderTTL.autoInvalidate(ref, duration: Duration(minutes: 5));

  final service = MyService(ref);
  return service.fetchMetrics();
});

// Periodic refresh: re-fetches every 2 minutes
final liveKpiProvider = FutureProvider.autoDispose<KpiModel>((ref) async {
  ProviderTTL.periodicRefresh(ref, interval: Duration(minutes: 2));

  final service = DashboardService(ref);
  return service.fetchKpis();
});
```

### Recommended TTLs:
| Data Type | TTL | Pattern |
|---|---|---|
| Dashboard KPIs | 5 min | `autoInvalidate` |
| Activity feed | 2 min | `periodicRefresh` |
| Role/profile data | 30 min | `autoInvalidate` |
| Static config | 1 hour | `autoInvalidate` |
| Intelligence insights | 10 min | `autoInvalidate` |

### Rules:
- ✅ Use `FutureProvider.autoDispose` (not `FutureProvider`) for TTL providers
- ✅ Set TTL appropriate to data freshness requirements
- ❌ **Never** leave dashboard metrics cached forever with no refresh

---

## Section 10: Layout Invariant Enforcement

**All screens must be rendered within the `MasterLayout` shell.** This ensures that sidebars, top app bars, governance telemetry, and global context are present. To prevent developers from accidentally routing directly to a screen without the shell, use the Governed Base Classes:

```dart
// ✅ CORRECT — extends GovernedConsumerWidget
class MyDashboardView extends GovernedConsumerWidget {
  const MyDashboardView({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    // The framework will assert AppShellBoundary.isActive(context) automatically
    return Container();
  }
}

// ❌ WRONG — extends standard ConsumerWidget directly
class MyDashboardView extends ConsumerWidget {
  const MyDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This allows routing directly to the view without the MasterLayout shell
    return Container();
  }
}
```

### Available Base Classes:
| Type | Use When |
|---|---|
| `GovernedConsumerWidget` | For Riverpod-connected stateless screens |
| `GovernedStatelessWidget` | For simple stateless screens |
| `GovernedConsumerStatefulWidget` | For Riverpod-connected stateful screens |

### Rules:
- ✅ **Always** extend `GovernedConsumerWidget` (or its variants) for top-level screens intended to be routed via GoRouter
- ✅ **Always** override `buildScreen` instead of `build`
- ❌ **Never** extend `StatelessWidget` or `ConsumerWidget` directly for top-level dashboard or governance screens

---

## Section 11: Omnichannel Responsive Constraint

**Prevent "ridiculous" UI stretching on ultra-wide (4K/100-inch) monitors.** All layout containers must be bounded, and grid implementations must use physical extent sizing rather than fixed column counts.

```dart
// ✅ CORRECT — Bounded width and extent-based grid
class DashboardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 350, // Card physical size is constrained
      children: [ /* ... */ ],
    );
  }
}

// ❌ WRONG — Infinite stretch on 4K monitors
class BadGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // At 3840px wide, each card becomes 1920px!
      children: [ /* ... */ ],
    );
  }
}
```

### Rules:
- ✅ **Always** use `GridView.extent` or `SliverGridDelegateWithMaxCrossAxisExtent` instead of `GridView.count` for flowing card layouts.
- ✅ **Always** ensure the primary shell (`MasterLayout`) uses `OmniConstraintWrapper` to cap content width at `OmniBreakpoints.maxContentWidth`.
- ❌ **Never** use `Expanded` to infinitely stretch core interactive components (like cards or buttons) across an unbounded screen width.

---

## Anti-Patterns — Never Do This

```dart
// ❌ 1. Bare try-catch in a service
Future<Map<String, dynamic>> fetchData() async {
  try {
    final response = await _apiClient.get('/data');
    return response.data;
  } catch (e) {
    return {}; // No telemetry, no Result wrapping
  }
}

// ❌ 2. Named parameters in fold()
result.fold(onSuccess: (data) => ..., onFailure: (e) => ...);

// ❌ 3. Force-unwrapping Result
final data = result.dataOrNull!; // Throws if failure

// ❌ 4. runApp without error boundary
void main() {
  runApp(MyApp()); // Any widget crash = grey screen, zero telemetry
}

// ❌ 5. Returning Future<T> from a service (not wrapped in Result)
Future<List<Patient>> getPatients() async { ... }
// Should be: Future<Result<List<Patient>>> getPatients() async { ... }

// ❌ 6. Making API calls without connectivity check
final result = await service.fetchData(); // 15s timeout if offline

// ❌ 7. FutureProvider without TTL for dashboard data
final myProvider = FutureProvider<MyModel>((ref) async { ... }); // stale forever

// ❌ 8. Using fixed column counts for fluid grids
GridView.count(crossAxisCount: 3); // Stretches out of control on large monitors
```

---

## Checklist — Before Merging Any PR

- [ ] Every new API call uses `Result.guardFuture`
- [ ] Every `Result` consumer uses `fold()` with positional params
- [ ] Every `passGate`/`failGate` uses the correct `ExecutionGateCategory`
- [ ] Every `onError` returns a safe fallback value (not null, not throw)
- [ ] No unbounded in-memory buffers
- [ ] New app entrypoints use `AppErrorBoundary.runGuarded`
- [ ] No bare `try-catch` blocks in service-layer code
- [ ] Dashboard/metrics providers have `ProviderTTL` set
- [ ] Data-loading providers check `isOnlineProvider` for offline fast-fail
- [ ] Top-level screens extend Governed classes (`GovernedConsumerWidget`) and override `buildScreen`
- [ ] Grids use `GridView.extent` and fluid containers do not infinitely stretch on 4K displays
