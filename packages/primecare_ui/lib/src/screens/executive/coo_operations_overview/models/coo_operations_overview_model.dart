import 'package:primecare_models/primecare_models.dart';

class CooOperationsOverviewModel extends BaseScreenState<CooOperationsOverviewModel> {
  const CooOperationsOverviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooOperationsOverviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooOperationsOverviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
