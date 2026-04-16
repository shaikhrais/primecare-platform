import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/approve_franchise_disclosure_form_view_model.dart';
import '../mappers/approve_franchise_disclosure_form_mapper.dart';

class ApproveFranchiseDisclosureFormAdapter
    extends Notifier<ApproveFranchiseDisclosureFormViewModel> {
  @override
  ApproveFranchiseDisclosureFormViewModel build() {
    return ApproveFranchiseDisclosureFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future.delayed(const Duration(seconds: 1));

      final dto = ApproveFranchiseDisclosureFormMapper.toDto(state);
      // ignore: avoid_print
      print('Approving franchise disclosure: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error approving franchise disclosure: \$e');
    }
  }
}

final approveFranchiseDisclosureFormAdapterProvider =
    NotifierProvider<
      ApproveFranchiseDisclosureFormAdapter,
      ApproveFranchiseDisclosureFormViewModel
    >(() {
      return ApproveFranchiseDisclosureFormAdapter();
    });
