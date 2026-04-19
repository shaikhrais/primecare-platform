import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';

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
