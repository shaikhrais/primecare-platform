// Governance - Category: state | Purpose: Riverpod state notifier for Marketing R O I Report
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketingROIReportNotifier extends StateNotifier<AsyncValue<void>> {
  MarketingROIReportNotifier() : super(const AsyncValue.data(null));
}
