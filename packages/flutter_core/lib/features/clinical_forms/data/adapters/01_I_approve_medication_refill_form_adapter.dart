// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/02_M_approve_medication_refill_form_view_model.dart';
import '../mappers/03_D_approve_medication_refill_form_mapper.dart';

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
