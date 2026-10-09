import 'package:primecare_models/primecare_models.dart';

class DailyOperationsModel extends BaseScreenState<DailyOperationsModel> {
  const DailyOperationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DailyOperationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DailyOperationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
