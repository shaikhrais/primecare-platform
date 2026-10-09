import 'package:primecare_models/primecare_models.dart';

class RpnPatientChartingModel extends BaseScreenState<RpnPatientChartingModel> {
  const RpnPatientChartingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RpnPatientChartingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RpnPatientChartingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
