// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/approve_medication_refill_form_view_model.dart';
import '../mappers/approve_medication_refill_form_mapper.dart';

class ApproveMedicationRefillFormAdapter
    extends Notifier<ApproveMedicationRefillFormViewModel> {
  @override
  ApproveMedicationRefillFormViewModel build() {
    return ApproveMedicationRefillFormViewModel();
  }

  Future<void> approveRefill() async {
    state = state.copyWith(isLoading: true);

    try {
      // Simulate network delay
      await Future<void>.delayed(const Duration(seconds: 1));

      state = state.copyWith(isLoading: false, status: 'Approved');

      final dto = ApproveMedicationRefillFormMapper.toDto(state);
      // ignore: avoid_print
      print('Refill Approved: ${dto.toJson()}');
    } catch (e) {
      state = state.copyWith(isLoading: false, status: 'Error');
      // ignore: avoid_print
      print('Error approving Refill: \$e');
    }
  }

  Future<void> rejectRefill() async {
    state = state.copyWith(isLoading: true);

    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      state = state.copyWith(isLoading: false, status: 'Rejected');
    } catch (e) {
      state = state.copyWith(isLoading: false, status: 'Error');
    }
  }
}

final approveMedicationRefillFormAdapterProvider =
    NotifierProvider<
      ApproveMedicationRefillFormAdapter,
      ApproveMedicationRefillFormViewModel
    >(() {
      return ApproveMedicationRefillFormAdapter();
    });
