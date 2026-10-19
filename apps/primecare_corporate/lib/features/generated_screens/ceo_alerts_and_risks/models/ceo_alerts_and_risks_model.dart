import 'package:primecare_models/primecare_models.dart';

class CeoAlertsAndRisksModel extends BaseScreenState<CeoAlertsAndRisksModel> {
  const CeoAlertsAndRisksModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoAlertsAndRisksModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoAlertsAndRisksModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
