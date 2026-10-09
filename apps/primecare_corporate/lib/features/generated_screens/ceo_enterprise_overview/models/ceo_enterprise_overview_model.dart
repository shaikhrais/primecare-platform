import 'package:primecare_models/primecare_models.dart';

class CeoEnterpriseOverviewModel extends BaseScreenState<CeoEnterpriseOverviewModel> {
  const CeoEnterpriseOverviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoEnterpriseOverviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoEnterpriseOverviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
