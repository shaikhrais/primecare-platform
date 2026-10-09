import 'package:primecare_models/primecare_models.dart';

class PatientRetentionAnalyticsModel extends BaseScreenState<PatientRetentionAnalyticsModel> {
  const PatientRetentionAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientRetentionAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientRetentionAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
