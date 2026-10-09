import 'package:primecare_models/primecare_models.dart';

class OperationsManagerDailyOperationsModel extends BaseScreenState<OperationsManagerDailyOperationsModel> {
  const OperationsManagerDailyOperationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerDailyOperationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerDailyOperationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
