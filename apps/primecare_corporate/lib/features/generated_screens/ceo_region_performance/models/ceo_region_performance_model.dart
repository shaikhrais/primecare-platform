import 'package:primecare_models/primecare_models.dart';

class CeoRegionPerformanceModel extends BaseScreenState<CeoRegionPerformanceModel> {
  const CeoRegionPerformanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoRegionPerformanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoRegionPerformanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
