import 'package:primecare_models/primecare_models.dart';

class GeneralManagerAnalyticsModel extends BaseScreenState<GeneralManagerAnalyticsModel> {
  const GeneralManagerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GeneralManagerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GeneralManagerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
