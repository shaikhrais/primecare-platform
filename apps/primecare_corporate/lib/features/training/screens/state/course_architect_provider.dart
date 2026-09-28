// Governance - Category: state | Purpose: Riverpod state notifier for Course Architect
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CourseArchitectNotifier extends StateNotifier<AsyncValue<void>> {
  CourseArchitectNotifier() : super(const AsyncValue.data(null));
}
