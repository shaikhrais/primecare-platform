import 'package:primecare_models/primecare_models.dart';

class LegalAnalyticsModel extends BaseScreenState<LegalAnalyticsModel> {
  const LegalAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LegalAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LegalAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
