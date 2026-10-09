import 'package:primecare_models/primecare_models.dart';

class FranchiseSalesManagerFollowUpsModel extends BaseScreenState<FranchiseSalesManagerFollowUpsModel> {
  const FranchiseSalesManagerFollowUpsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseSalesManagerFollowUpsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerFollowUpsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
