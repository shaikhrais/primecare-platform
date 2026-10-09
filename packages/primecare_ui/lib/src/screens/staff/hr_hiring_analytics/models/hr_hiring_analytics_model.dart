import 'package:primecare_models/primecare_models.dart';

class HrHiringAnalyticsModel extends BaseScreenState<HrHiringAnalyticsModel> {
  const HrHiringAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
