// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/02_M_submit_marketing_budget_form_view_model.dart';
import '../mappers/03_D_submit_marketing_budget_form_mapper.dart';

class SubmitMarketingBudgetFormAdapter
    extends Notifier<SubmitMarketingBudgetFormViewModel> {
  @override
  SubmitMarketingBudgetFormViewModel build() {
    return SubmitMarketingBudgetFormViewModel();
  }

  Future<void> submitBudget() async {
    state = state.copyWith(isLoading: true);

    try {
      // Simulate network delay
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = SubmitMarketingBudgetFormMapper.toDto(state);
      // ignore: avoid_print
      print('Submitting Budget: ${dto.toJson()}');

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // ignore: avoid_print
      print('Error submitting budget: \$e');
    }
  }

  void updateField({
    String? campaignName,
    double? totalBudget,
    DateTime? startDate,
    DateTime? endDate,
    String? platform,
    String? details,
  }) {
    state = state.copyWith(
      campaignName: campaignName,
      totalBudget: totalBudget,
      startDate: startDate,
      endDate: endDate,
      platform: platform,
      details: details,
    );
  }
}

final submitMarketingBudgetFormAdapterProvider =
    NotifierProvider<
      SubmitMarketingBudgetFormAdapter,
      SubmitMarketingBudgetFormViewModel
    >(() {
      return SubmitMarketingBudgetFormAdapter();
    });
