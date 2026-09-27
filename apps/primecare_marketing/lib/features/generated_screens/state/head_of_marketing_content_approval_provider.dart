// Governance - Category: state | Purpose: Riverpod state notifier for Head Of Marketing Content Approval
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfMarketingContentApprovalNotifier extends StateNotifier<AsyncValue<void>> {
  HeadOfMarketingContentApprovalNotifier() : super(const AsyncValue.data(null));
}
