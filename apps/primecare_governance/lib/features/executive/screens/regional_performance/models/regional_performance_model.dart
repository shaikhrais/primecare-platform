import 'package:primecare_models/primecare_models.dart';

class RegionalPerformanceModel extends BaseScreenState<RegionalPerformanceModel> {
  const RegionalPerformanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalPerformanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalPerformanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
