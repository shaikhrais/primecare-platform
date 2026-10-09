import 'package:primecare_models/primecare_models.dart';

class PortalAnalyticsModel extends BaseScreenState<PortalAnalyticsModel> {
  const PortalAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PortalAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PortalAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
