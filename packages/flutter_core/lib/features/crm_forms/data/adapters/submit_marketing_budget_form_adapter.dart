// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/submit_marketing_budget_form_view_model.dart';
import '../mappers/submit_marketing_budget_form_mapper.dart';

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
