import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CourseAssignmentScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseAssignmentNotifier extends StateNotifier<AsyncValue<void>> {
  CourseAssignmentNotifier() : super(const AsyncValue.data(null));
}
