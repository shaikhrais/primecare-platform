import 'package:primecare_models/primecare_models.dart';

class FranchiseOwnerStaffModel extends BaseScreenState<FranchiseOwnerStaffModel> {
  const FranchiseOwnerStaffModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOwnerStaffModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerStaffModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
