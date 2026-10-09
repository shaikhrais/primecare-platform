import 'package:primecare_models/primecare_models.dart';

class CeoFranchiseOverviewModel extends BaseScreenState<CeoFranchiseOverviewModel> {
  const CeoFranchiseOverviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoFranchiseOverviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoFranchiseOverviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
