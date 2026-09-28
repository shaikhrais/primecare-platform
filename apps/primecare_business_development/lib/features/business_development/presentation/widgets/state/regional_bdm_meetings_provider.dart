// Governance - Category: state | Purpose: Riverpod state notifier for Regional Bdm Meetings
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RegionalBdmMeetingsNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalBdmMeetingsNotifier() : super(const AsyncValue.data(null));
}
