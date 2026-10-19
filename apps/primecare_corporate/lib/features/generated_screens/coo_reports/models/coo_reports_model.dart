import 'package:primecare_models/primecare_models.dart';

class CooReportsModel extends BaseScreenState<CooReportsModel> {
  const CooReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
