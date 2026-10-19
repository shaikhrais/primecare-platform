import 'package:primecare_models/primecare_models.dart';

class CtoReportsModel extends BaseScreenState<CtoReportsModel> {
  const CtoReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
