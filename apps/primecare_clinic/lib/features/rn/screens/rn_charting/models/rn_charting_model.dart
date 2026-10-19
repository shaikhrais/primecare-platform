import 'package:primecare_models/primecare_models.dart';

class RnChartingModel extends BaseScreenState<RnChartingModel> {
  const RnChartingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnChartingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnChartingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
