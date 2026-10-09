import 'package:primecare_models/primecare_models.dart';

class BusinessDevelopmentAnalyticsModel extends BaseScreenState<BusinessDevelopmentAnalyticsModel> {
  const BusinessDevelopmentAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BusinessDevelopmentAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BusinessDevelopmentAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
