import 'package:primecare_models/primecare_models.dart';

class DynamicAnalyticsModel extends BaseScreenState<DynamicAnalyticsModel> {
  const DynamicAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DynamicAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DynamicAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
