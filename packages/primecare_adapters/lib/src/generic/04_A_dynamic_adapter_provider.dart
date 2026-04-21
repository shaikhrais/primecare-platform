// Layer: 04_UI_ADAPTERS
import '../../primecare_adapters.dart';

/// Provider for the generic [DynamicScreenAdapter].
/// Allows any UI component to dynamically hydrate its data by role/form.
final dynamicAdapterProvider = Provider.family<DynamicScreenAdapter, PrimeCareForm>((ref, form) {
  return DynamicScreenAdapter(ref, form);
});
