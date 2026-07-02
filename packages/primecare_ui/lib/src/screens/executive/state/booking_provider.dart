// Governance - Category: state | Purpose: Riverpod state notifier for BookingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingNotifier extends StateNotifier<AsyncValue<void>> {
  BookingNotifier() : super(const AsyncValue.data(null));
}
