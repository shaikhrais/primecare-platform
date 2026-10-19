import 'package:primecare_models/primecare_models.dart';

class ArchitecturePlanningAnalyticsModel extends BaseScreenState<ArchitecturePlanningAnalyticsModel> {
  const ArchitecturePlanningAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ArchitecturePlanningAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ArchitecturePlanningAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
