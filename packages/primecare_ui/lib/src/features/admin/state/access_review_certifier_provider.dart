import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Access Review Certifier
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessReviewCertifierNotifier extends StateNotifier<AsyncValue<void>> {
  AccessReviewCertifierNotifier() : super(const AsyncValue.data(null));
}
