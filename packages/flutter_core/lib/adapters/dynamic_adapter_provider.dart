import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dynamic_screen_adapter.dart';
import 'package:primecare_core/api_providers.dart';

final dynamicScreenAdapterProvider =
    Provider.family<DynamicScreenAdapter, String>((ref, screenId) {
      final apiClient = ref.watch(apiClientProvider);
      return DynamicScreenAdapter(screenId: screenId, apiClient: apiClient);
    });

final dynamicScreenViewModelProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, screenId) async {
      final adapter = ref.watch(dynamicScreenAdapterProvider(screenId));
      return await adapter.getData();
    });
