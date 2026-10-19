import 'package:primecare_models/primecare_models.dart';

class FranchiseOwnerFinancialSnapshotModel extends BaseScreenState<FranchiseOwnerFinancialSnapshotModel> {
  const FranchiseOwnerFinancialSnapshotModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOwnerFinancialSnapshotModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerFinancialSnapshotModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
