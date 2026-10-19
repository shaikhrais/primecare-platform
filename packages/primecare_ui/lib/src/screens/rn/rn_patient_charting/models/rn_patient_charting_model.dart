import 'package:primecare_models/primecare_models.dart';

class RnPatientChartingModel extends BaseScreenState<RnPatientChartingModel> {
  const RnPatientChartingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnPatientChartingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnPatientChartingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
