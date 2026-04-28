// Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global provider for [SharedPreferences].
/// This should be overridden in the app's [ProviderScope] with the actual instance.
/// We provide null as a default to allow non-blocking initialization of the provider graph.
final sharedPreferencesProvider = Provider<SharedPreferences?>((ref) {
  return null;
});
