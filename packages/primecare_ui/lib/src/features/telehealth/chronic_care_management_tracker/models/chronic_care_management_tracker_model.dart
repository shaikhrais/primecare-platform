import 'package:primecare_models/primecare_models.dart';

class ChronicCareManagementTrackerModel extends BaseScreenState<ChronicCareManagementTrackerModel> {
  const ChronicCareManagementTrackerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChronicCareManagementTrackerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChronicCareManagementTrackerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
