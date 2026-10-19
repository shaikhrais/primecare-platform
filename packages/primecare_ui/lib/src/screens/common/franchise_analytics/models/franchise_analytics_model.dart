import 'package:primecare_models/primecare_models.dart';

class FranchiseAnalyticsModel extends BaseScreenState<FranchiseAnalyticsModel> {
  const FranchiseAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
