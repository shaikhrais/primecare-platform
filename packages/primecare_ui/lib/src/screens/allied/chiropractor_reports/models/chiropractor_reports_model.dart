import 'package:primecare_models/primecare_models.dart';

class ChiropractorReportsModel extends BaseScreenState<ChiropractorReportsModel> {
  const ChiropractorReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
