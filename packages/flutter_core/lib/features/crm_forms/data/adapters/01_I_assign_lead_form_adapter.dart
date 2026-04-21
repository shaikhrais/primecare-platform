// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/02_M_assign_lead_form_view_model.dart';
import '../mappers/03_D_assign_lead_form_mapper.dart';

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
