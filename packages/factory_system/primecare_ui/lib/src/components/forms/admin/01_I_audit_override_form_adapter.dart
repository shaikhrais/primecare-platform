// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'dart:async';


// --- State Model ---
class AuditOverrideData {
  final String name;
  final String details;

  AuditOverrideData({
    this.name = '',
    this.details = '',
  });

  AuditOverrideData copyWith({
    String? name,
    String? details,
  }) {
    return AuditOverrideData(
      name: name ?? this.name,
      details: details ?? this.details,
    );
  }
}

// --- Notifier / Business Logic Adapter ---
class AuditOverrideFormAdapter extends AsyncNotifier<AuditOverrideData> {
  @override
  FutureOr<AuditOverrideData> build() async {
    // Initial empty state
    return AuditOverrideData();
  }

  void updateData({
    String? name,
    String? details,
  }) {
    final current = state.value ?? AuditOverrideData();
    state = AsyncData(
      current.copyWith(
        name: name,
        details: details,
      ),
    );
  }

  Future<bool> submit() async {
    final currentData = state.value;
    if (currentData == null) return false;
    
    // Fast-fail if offline
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      state = AsyncError('Device is offline. Please check your connection.', StackTrace.current);
      return false;
    }

    state = const AsyncLoading();

    final result = await ref.read(domainServiceProvider).requestAuditOverride({
      'name': currentData.name,
      'details': currentData.details,
    });

    return result.fold(
      (data) {
        // Reset form
        state = AsyncData(AuditOverrideData());
        return true;
      },
      (failure) {
        state = AsyncError(failure.toString(), StackTrace.current);
        return false;
      },
    );
  }
}

final auditOverrideFormAdapterProvider =
    AsyncNotifierProvider<AuditOverrideFormAdapter, AuditOverrideData>(
  () => AuditOverrideFormAdapter(),
);
