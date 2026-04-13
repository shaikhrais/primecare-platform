import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/adapters/dynamic_adapter_provider.dart';
import 'primecare_form_enum.dart';

export 'primecare_form_enum.dart';

/// Topology V2: Enum-Driven Families
/// This strongly typifies form IDs to exactly the 578 valid identifiers without 
/// the need for code generation across hundreds of files.
final formSchemaDataProvider = FutureProvider.family<Map<String, dynamic>, PrimeCareForm>((ref, form) async {
  final adapter = ref.watch(dynamicScreenAdapterProvider(form.id));
  return await adapter.getData();
});
