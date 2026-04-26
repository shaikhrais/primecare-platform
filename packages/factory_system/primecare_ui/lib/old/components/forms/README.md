# PrimeCare Forms Architecture

This directory contains the core UI data entry layer. To maintain high enterprise resiliency, strict validation, and an identical UX pipeline, ALL forms moving forward **MUST** adhere to the standard Data Entry Architecture defined here.

## 1. State Management Pattern
Forms are notoriously fragile. To prevent memory leaks, unhandled Future exceptions, and state misalignment, **all view models must use `AsyncNotifierProvider` (`AsyncNotifier<T>`)**. DO NOT use `StateNotifier`, `ChangeNotifier`, or plain `StateProvider`.

```dart
// BAD
final badProvider = StateProvider<bool>((ref) => false);

// GOOD
class FormNotifier extends AsyncNotifier<FormData> {
  @override
  FutureOr<FormData> build() {
    return const FormData();
  }
}
final formProvider = AsyncNotifierProvider<FormNotifier, FormData>(FormNotifier.new);
```

## 2. Validation & Flow Control
Instead of directly calling multiple endpoint hooks in the UI and scattering logic, push network flow into the Notifier's `submit()` method. 

You MUST wrap network requests with `Result.guardFuture(...)` to ensure no uncaught UI exceptions bubble up, and you MUST report critical network successes/failures to `executionGateProvider` so our telemetry engines can trace form drops.

```dart
// Inside FormNotifier
Future<void> submit() async {
  state = const AsyncLoading();
  
  final result = await Result.guardFuture(() async {
    // 1. Telemetry Log
    ref.read(executionGateProvider).passGate('form_domain', 'Submitting form...');
    
    // 2. Await actual API
    await _apiLayer.postData(state.value!);
    return true;
  });

  state = result.when(
    success: (val) => AsyncData(state.value!),
    failure: (err) => AsyncError(err.error, err.stackTrace),
  );
}
```

## 3. UI Layer (BaseForm)
All forms **must** be wrapped in a `BaseForm`. `BaseForm` intercepts the overarching `isLoading` argument to gray-out children, swallow tap points (`AbsorbPointer`), and configure Keyboard hooks (e.g. `Enter` to submit).

Layouts **shall not** use hard-coded padding or manual Rows unless explicitly overriding the tier. Everything must be mapped onto `ResponsiveGridRow` with `ResponsiveGridCol` snapping values according to breakpoints.

```dart
// Standard implementation:
@override
Widget build(BuildContext context, WidgetRef ref) {
  final asyncState = ref.watch(formProvider);
  final layout = PrimeCareDesignSystem.of(context).layout;
  
  return BaseForm(
    title: "Vitals Capture",
    subtitle: "Enterprise data integration",
    isLoading: asyncState.isLoading,
    errorText: asyncState.hasError ? asyncState.error.toString() : null,
    onSubmit: () => ref.read(formProvider.notifier).submit(),
    child: ResponsiveGridRow(
      children: [
        ResponsiveGridCol(
          span: layout.tier == ResolutionTier.mob ? 12 : 4,
          child: TextFormField(
            initialValue: asyncState.value?.field,
            onChanged: (val) => ref.read(formProvider.notifier).updateData(field: val),
          ),
        ),
      ]
    ),
  );
}
```

By following this pattern, we ensure the UI reacts resiliently to loading screens, form logic remains easily testable headless (`Flutter test`), and errors map beautifully to the PrimeCare error states natively built into `BaseForm`.
