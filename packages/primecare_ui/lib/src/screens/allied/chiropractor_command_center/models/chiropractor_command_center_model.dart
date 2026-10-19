import 'package:primecare_models/primecare_models.dart';

class ChiropractorCommandCenterModel extends BaseScreenState<ChiropractorCommandCenterModel> {
  const ChiropractorCommandCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorCommandCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorCommandCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
