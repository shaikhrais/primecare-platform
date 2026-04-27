// Layer: 01_INFRASTRUCTURE
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
