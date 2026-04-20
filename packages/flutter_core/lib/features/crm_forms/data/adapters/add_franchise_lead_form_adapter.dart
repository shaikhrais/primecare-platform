// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/add_franchise_lead_form_view_model.dart';
import '../mappers/add_franchise_lead_form_mapper.dart';

class AddFranchiseLeadFormAdapter
    extends Notifier<AddFranchiseLeadFormViewModel> {
  @override
  AddFranchiseLeadFormViewModel build() {
    return AddFranchiseLeadFormViewModel();
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true);

    try {
      // Simulate network delay
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = AddFranchiseLeadFormMapper.toDto(state);
      // ignore: avoid_print
      print('Creating new lead: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, status: 'Submitted');
    } catch (e) {
      state = state.copyWith(isLoading: false, status: 'Error');
      // ignore: avoid_print
      print('Error creating lead: \$e');
    }
  }

  void updateField({
    String? name,
    String? email,
    String? phone,
    String? territoryOfInterest,
    String? details,
  }) {
    state = state.copyWith(
      name: name,
      email: email,
      phone: phone,
      territoryOfInterest: territoryOfInterest,
      details: details,
    );
  }
}

final addFranchiseLeadFormAdapterProvider =
    NotifierProvider<
      AddFranchiseLeadFormAdapter,
      AddFranchiseLeadFormViewModel
    >(() {
      return AddFranchiseLeadFormAdapter();
    });
