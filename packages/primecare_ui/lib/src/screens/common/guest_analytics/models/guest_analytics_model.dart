import 'package:primecare_models/primecare_models.dart';

class GuestAnalyticsModel extends BaseScreenState<GuestAnalyticsModel> {
  const GuestAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GuestAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GuestAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
