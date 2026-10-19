import 'package:primecare_models/primecare_models.dart';

class CtoApiMonitoringModel extends BaseScreenState<CtoApiMonitoringModel> {
  const CtoApiMonitoringModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoApiMonitoringModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoApiMonitoringModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
