import 'package:primecare_models/primecare_models.dart';

class HeadOfBusDevAnalyticsModel extends BaseScreenState<HeadOfBusDevAnalyticsModel> {
  const HeadOfBusDevAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfBusDevAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfBusDevAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
