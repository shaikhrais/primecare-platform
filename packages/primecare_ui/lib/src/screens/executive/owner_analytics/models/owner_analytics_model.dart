import 'package:primecare_models/primecare_models.dart';

class OwnerAnalyticsModel extends BaseScreenState<OwnerAnalyticsModel> {
  const OwnerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OwnerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OwnerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
