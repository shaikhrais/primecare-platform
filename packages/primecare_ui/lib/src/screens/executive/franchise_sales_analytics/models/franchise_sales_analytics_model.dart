import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesAnalyticsModel extends BaseScreenState<FranchiseSalesAnalyticsModel> {
  const FranchiseSalesAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
