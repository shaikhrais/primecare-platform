import 'package:primecare_models/primecare_models.dart';

class MonitoringModel extends BaseScreenState<MonitoringModel> {
  const MonitoringModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MonitoringModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MonitoringModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
