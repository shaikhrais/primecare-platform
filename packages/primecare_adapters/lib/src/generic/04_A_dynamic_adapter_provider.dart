// Layer: 04_UI_ADAPTERS
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../primecare_adapters.dart';
import '04_A_dynamic_screen_adapter.dart';

/// Provider for the generic [DynamicScreenAdapter].
/// Allows any UI component to dynamically hydrate its data by role/form.
final dynamicAdapterProvider = Provider.family<DynamicScreenAdapter, PrimeCareForm>((ref, form) {
  return DynamicScreenAdapter(ref, form);
});
