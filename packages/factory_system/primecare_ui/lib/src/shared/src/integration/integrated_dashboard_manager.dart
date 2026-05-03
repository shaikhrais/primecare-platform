// Layer: 01_INTEGRATION
// Architecture: Unified Dashboard Intelligence Manager
// This class handles the sync between API, Store, and UI with high precision.

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../resilience_service.dart';
import '../result.dart';
import '../models/core/intelligence_dashboard_model.dart';

/// [Architecture: MVC-I] - Integrated Model-View-Controller
/// A unified manager that handles API integration, State Management, and Persistence.
abstract class IntegratedDashboardManager extends AsyncNotifier<Result<IntelligenceDashboardModel>> {
  
  /// Unique key for local persistence
  String get storageKey;

  /// The role/tag for this specific dashboard instance
  String get role;

  /// Fetch remote data from the Backend API
  Future<IntelligenceDashboardModel> fetchRemote(String role);

  @override
  FutureOr<Result<IntelligenceDashboardModel>> build() async {
    return _synchronize();
  }

  /// The core "Unbreakable" Sync Logic:
  /// Attempts Remote -> Falls back to Local Store -> Reports via Result
  Future<Result<IntelligenceDashboardModel>> _synchronize() async {
    final resilience = ref.read(resilienceServiceProvider);
    
    try {
      final model = await fetchRemote(role);
      
      // Precision Save: Persist the clean remote data to the store
      await resilience.saveSnapshot('${storageKey}_$role', model.toJson());
      
      return Success(model);
    } catch (e) {
      // Self-Healing: Fallback to the persistent store (Precision Class)
      final snapshot = resilience.getSnapshot('${storageKey}_$role');
      if (snapshot != null) {
        try {
          return Success(IntelligenceDashboardModel.fromJson(snapshot));
        } catch (parseError) {
          return Failure(Exception('Persistence Corruption: $parseError'));
        }
      }
      return Failure(Exception('Integration Failure: Both Remote and Local sources are unavailable.'));
    }
  }

  /// Manual trigger to refresh the entire intelligence cycle
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final result = await _synchronize();
    state = AsyncValue.data(result);
  }
}
