import 'package:primecare_models/primecare_models.dart';

class PswReportsModel extends BaseScreenState<PswReportsModel> {
  const PswReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
