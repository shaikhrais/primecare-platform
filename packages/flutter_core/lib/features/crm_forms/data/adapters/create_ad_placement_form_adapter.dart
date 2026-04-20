// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/create_ad_placement_form_view_model.dart';
import '../mappers/create_ad_placement_form_mapper.dart';

class CreateAdPlacementFormAdapter
    extends Notifier<CreateAdPlacementFormViewModel> {
  @override
  CreateAdPlacementFormViewModel build() {
    return CreateAdPlacementFormViewModel();
  }

  void updateData(Map<String, dynamic> newData) {
    state = state.copyWith(data: {...state.data, ...newData});
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // API call simulated
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = CreateAdPlacementFormMapper.toDto(state);
      // ignore: avoid_print
      print('Creating ad placement: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // ignore: avoid_print
      print('Error creating ad placement: \$e');
    }
  }
}

final createAdPlacementFormAdapterProvider =
    NotifierProvider<
      CreateAdPlacementFormAdapter,
      CreateAdPlacementFormViewModel
    >(() {
      return CreateAdPlacementFormAdapter();
    });
