import 'package:primecare_models/primecare_models.dart';

class FranchiseOwnerFinanceSnapshotModel extends BaseScreenState<FranchiseOwnerFinanceSnapshotModel> {
  const FranchiseOwnerFinanceSnapshotModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOwnerFinanceSnapshotModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerFinanceSnapshotModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
