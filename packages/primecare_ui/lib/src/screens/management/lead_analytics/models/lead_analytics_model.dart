import 'package:primecare_models/primecare_models.dart';

class LeadAnalyticsModel extends BaseScreenState<LeadAnalyticsModel> {
  const LeadAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LeadAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LeadAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
