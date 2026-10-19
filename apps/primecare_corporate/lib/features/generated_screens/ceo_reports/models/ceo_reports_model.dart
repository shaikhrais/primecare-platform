import 'package:primecare_models/primecare_models.dart';

class CeoReportsModel extends BaseScreenState<CeoReportsModel> {
  const CeoReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
