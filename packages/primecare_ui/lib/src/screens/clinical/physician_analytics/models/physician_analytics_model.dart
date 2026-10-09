import 'package:primecare_models/primecare_models.dart';

class PhysicianAnalyticsModel extends BaseScreenState<PhysicianAnalyticsModel> {
  const PhysicianAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysicianAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysicianAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
