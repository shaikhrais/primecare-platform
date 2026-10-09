import 'package:primecare_models/primecare_models.dart';

class GamificationProfileModel extends BaseScreenState<GamificationProfileModel> {
  const GamificationProfileModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GamificationProfileModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GamificationProfileModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
