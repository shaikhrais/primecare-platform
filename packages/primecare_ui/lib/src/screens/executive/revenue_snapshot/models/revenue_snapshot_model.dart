import 'package:primecare_models/primecare_models.dart';

class RevenueSnapshotModel extends BaseScreenState<RevenueSnapshotModel> {
  const RevenueSnapshotModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RevenueSnapshotModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RevenueSnapshotModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
