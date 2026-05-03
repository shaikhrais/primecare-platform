import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/logger.dart';

final universalDataEntryProvider =
    NotifierProvider<UniversalDataEntryController, UniversalDataEntryState>(
        UniversalDataEntryController.new);

class UniversalDataEntryState {
  final bool isSubmitting;
  final String? lastSubmissionId;
  final String? error;

  UniversalDataEntryState({
    this.isSubmitting = false,
    this.lastSubmissionId,
    this.error,
  });

  UniversalDataEntryState copyWith({
    bool? isSubmitting,
    String? lastSubmissionId,
    String? error,
  }) {
    return UniversalDataEntryState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      lastSubmissionId: lastSubmissionId ?? this.lastSubmissionId,
      error: error ?? this.error,
    );
  }
}

class UniversalDataEntryController extends Notifier<UniversalDataEntryState> {
  @override
  UniversalDataEntryState build() => UniversalDataEntryState();

  Future<void> submitData(Map<String, dynamic> data) async {
    state = state.copyWith(isSubmitting: true);
    try {
      AppLogger.i('Submitting batch data: $data');
      await Future.delayed(const Duration(seconds: 2));
      state = state.copyWith(
        isSubmitting: false,
        lastSubmissionId: 'BATCH-${DateTime.now().millisecondsSinceEpoch}',
      );
    } catch (e) {
      AppLogger.e('Data entry submission failed: $e');
      state = state.copyWith(isSubmitting: false, error: e.toString());
    }
  }
}
