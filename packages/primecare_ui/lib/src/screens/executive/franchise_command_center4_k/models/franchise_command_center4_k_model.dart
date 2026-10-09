import 'package:primecare_models/primecare_models.dart';

class FranchiseCommandCenter4KModel extends BaseScreenState<FranchiseCommandCenter4KModel> {
  const FranchiseCommandCenter4KModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseCommandCenter4KModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseCommandCenter4KModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
