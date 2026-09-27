// Governance - Category: controller | Purpose: Global provider for SharedPreferences. This provider must be overridden in the [ProviderScope] with the actual instan...
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global provider for SharedPreferences.
/// This provider must be overridden in the [ProviderScope] with the actual instance.
final sharedPreferencesProvider = Provider<SharedPreferences?>((ref) {
  // This is a placeholder. The actual value is provided via override in main.dart.
  return null;
});
