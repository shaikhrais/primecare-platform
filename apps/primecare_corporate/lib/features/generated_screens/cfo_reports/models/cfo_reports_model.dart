import 'package:primecare_models/primecare_models.dart';

class CfoReportsModel extends BaseScreenState<CfoReportsModel> {
  const CfoReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
