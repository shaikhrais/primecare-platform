import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerAnalyticsModel extends BaseScreenState<FranchiseSalesManagerAnalyticsModel> {
  const FranchiseSalesManagerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
