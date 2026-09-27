// Governance - Category: state | Purpose: Riverpod state notifier for Regional Bdm Partners
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmPartnersNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalBdmPartnersNotifier() : super(const AsyncValue.data(null));
}
