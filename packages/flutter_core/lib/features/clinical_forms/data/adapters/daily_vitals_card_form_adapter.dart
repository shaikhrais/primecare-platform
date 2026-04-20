// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/daily_vitals_card_form_view_model.dart';
import '../mappers/daily_vitals_card_form_mapper.dart';

class DailyVitalsCardFormAdapter
    extends Notifier<DailyVitalsCardFormViewModel> {
  @override
  DailyVitalsCardFormViewModel build() {
    return DailyVitalsCardFormViewModel();
  }

  Future<void> saveVitals() async {
    state = state.copyWith(isLoading: true);

    try {
      // Simulate network delay
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = DailyVitalsCardFormMapper.toDto(state);
      // ignore: avoid_print
      print('Saving Daily Vitals: ${dto.toJson()}');

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // ignore: avoid_print
      print('Error saving Daily Vitals: \$e');
    }
  }

  void updateVitals({
    double? temperature,
    int? heartRate,
    int? bloodPressureSystolic,
    int? bloodPressureDiastolic,
    int? oxygenSaturation,
  }) {
    state = state.copyWith(
      temperature: temperature,
      heartRate: heartRate,
      bloodPressureSystolic: bloodPressureSystolic,
      bloodPressureDiastolic: bloodPressureDiastolic,
      oxygenSaturation: oxygenSaturation,
    );
  }
}

final dailyVitalsCardFormAdapterProvider =
    NotifierProvider<DailyVitalsCardFormAdapter, DailyVitalsCardFormViewModel>(
      () {
        return DailyVitalsCardFormAdapter();
      },
    );
