import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerDiscoveryCallsModel extends BaseScreenState<FranchiseSalesManagerDiscoveryCallsModel> {
  const FranchiseSalesManagerDiscoveryCallsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerDiscoveryCallsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerDiscoveryCallsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
