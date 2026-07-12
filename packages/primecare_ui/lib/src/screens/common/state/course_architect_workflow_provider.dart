import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CourseArchitectWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseArchitectWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  CourseArchitectWorkflowNotifier() : super(const AsyncValue.data(null));
}
