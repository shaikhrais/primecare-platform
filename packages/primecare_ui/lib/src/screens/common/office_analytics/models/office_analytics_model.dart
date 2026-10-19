import 'package:primecare_models/primecare_models.dart';

class OfficeAnalyticsModel extends BaseScreenState<OfficeAnalyticsModel> {
  const OfficeAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OfficeAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OfficeAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
