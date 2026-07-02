// Governance - Category: state | Purpose: Riverpod state notifier for Training Coordinator Courses
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorCoursesNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingCoordinatorCoursesNotifier() : super(const AsyncValue.data(null));
}
