// Governance - Category: state | Purpose: Riverpod state notifier for CourseArchitectAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseArchitectAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  CourseArchitectAnalyticsNotifier() : super(const AsyncValue.data(null));
}
