// Governance - Category: state | Purpose: Riverpod state notifier for SocialWorkerComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialWorkerComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  SocialWorkerComplianceNotifier() : super(const AsyncValue.data(null));
}
