import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CourseArchitectDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseArchitectDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CourseArchitectDashboardNotifier() : super(const AsyncValue.data(null));
}
