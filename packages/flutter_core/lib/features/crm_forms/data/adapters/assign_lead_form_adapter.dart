// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/assign_lead_form_view_model.dart';
import '../mappers/assign_lead_form_mapper.dart';

class AssignLeadFormAdapter extends Notifier<AssignLeadFormViewModel> {
  @override
  AssignLeadFormViewModel build() {
    return AssignLeadFormViewModel();
  }

  Future<void> assignLead() async {
    state = state.copyWith(isLoading: true);

    try {
      // Simulate network delay
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = AssignLeadFormMapper.toDto(state);
      // ignore: avoid_print
      print('Assigning Lead: ${dto.toJson()}');

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // ignore: avoid_print
      print('Error assigning lead: \$e');
    }
  }

  void updateField({
    String? leadId,
    String? assignedToId,
    String? priority,
    String? notes,
  }) {
    state = state.copyWith(
      leadId: leadId,
      assignedToId: assignedToId,
      priority: priority,
      notes: notes,
    );
  }
}

final assignLeadFormAdapterProvider =
    NotifierProvider<AssignLeadFormAdapter, AssignLeadFormViewModel>(() {
      return AssignLeadFormAdapter();
    });
