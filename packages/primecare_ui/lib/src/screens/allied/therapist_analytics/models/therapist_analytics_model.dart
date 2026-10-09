import 'package:primecare_models/primecare_models.dart';

class TherapistAnalyticsModel extends BaseScreenState<TherapistAnalyticsModel> {
  const TherapistAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TherapistAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TherapistAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
