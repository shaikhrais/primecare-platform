// Governance - Category: controller | Purpose: Notifier to manage global content zoom scale factor. Persists the value to SharedPreferences so that user zoom settin...
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'persistence_providers.dart';

/// Notifier to manage global content zoom scale factor.
/// Persists the value to SharedPreferences so that user zoom settings
/// are retained across sessions. Uses modern Riverpod v3 Notifier pattern.
class ContentZoom extends Notifier<double> {
  static const String _zoomKey = 'pref_content_zoom';

  @override
  double build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    if (prefs != null) {
      final saved = prefs.getDouble(_zoomKey);
      if (saved != null) {
        return saved;
      }
    }
    return 1.0;
  }

  Future<void> zoomIn() async {
    final next = (state + 0.1).clamp(0.7, 1.8);
    state = double.parse(next.toStringAsFixed(1)); // avoid double precision drift
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs != null) {
      await prefs.setDouble(_zoomKey, state);
    }
  }

  Future<void> zoomOut() async {
    final next = (state - 0.1).clamp(0.7, 1.8);
    state = double.parse(next.toStringAsFixed(1)); // avoid double precision drift
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs != null) {
      await prefs.setDouble(_zoomKey, state);
    }
  }

  Future<void> resetZoom() async {
    state = 1.0;
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs != null) {
      await prefs.remove(_zoomKey);
    }
  }
}

/// Global provider for managing content zoom/scale factor.
final contentZoomProvider = NotifierProvider<ContentZoom, double>(ContentZoom.new);
