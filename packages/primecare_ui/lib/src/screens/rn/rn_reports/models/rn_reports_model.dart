import 'package:primecare_models/primecare_models.dart';

class RnReportsModel extends BaseScreenState<RnReportsModel> {
  const RnReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
