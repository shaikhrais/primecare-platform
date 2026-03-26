import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';

// Unified Provider mapping dynamically using the specific active role natively!
final universalDashboardProvider = FutureProvider.family.autoDispose<Map<String, dynamic>, String>((
  ref,
  roleLiteral,
) async {
  // Pass the target role safely into the generalized router natively
  final response = await apiClient.get('/api/$roleLiteral/home/stats');

  if (response is Map) {
    if (response.containsKey('mocked') || response.containsKey('error')) {
      return {};
    }
    return response as Map<String, dynamic>;
  } else {
    throw Exception(
      'Failed to load Universal Dashboard natively seamlessly structurally. Mismatch in API Signature.',
    );
  }
});
