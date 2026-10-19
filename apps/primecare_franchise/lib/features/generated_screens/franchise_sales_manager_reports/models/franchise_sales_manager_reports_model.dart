import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerReportsModel extends BaseScreenState<FranchiseSalesManagerReportsModel> {
  const FranchiseSalesManagerReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
