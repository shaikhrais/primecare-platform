import 'package:primecare_models/primecare_models.dart';

class StaffUtilizationHeatmapModel extends BaseScreenState<StaffUtilizationHeatmapModel> {
  const StaffUtilizationHeatmapModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  StaffUtilizationHeatmapModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => StaffUtilizationHeatmapModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
