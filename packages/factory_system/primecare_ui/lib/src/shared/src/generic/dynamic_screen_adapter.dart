// Layer: 04_UI_ADAPTERS
import '../../primecare_adapters.dart';

/// A generic adapter that can build any dashboard screen dynamically
/// based on the provided [PrimeCareForm] registry key.
class DynamicScreenAdapter {
  final Ref ref;
  final PrimeCareForm form;

  DynamicScreenAdapter(this.ref, this.form);

  /// Watches the hydrated data for this form.
  AsyncValue<Result<PrimeCareDashboardViewModel>> watchData() {
    final adapterProvider = ref.watch(primecareFormProvider(form));
    // ignore: argument_type_not_assignable
    return ref.watch(adapterProvider);
  }

  /// Triggers a manual refresh of the underlying data.
  Future<void> refresh() async {
    final adapterProvider = ref.read(primecareFormProvider(form));
    // ignore: avoid_dynamic_calls, argument_type_not_assignable
    return ref.refresh(adapterProvider.future);
  }
}
