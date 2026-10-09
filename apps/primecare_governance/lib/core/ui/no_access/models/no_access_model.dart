import 'package:primecare_models/primecare_models.dart';

class NoAccessModel extends BaseScreenState<NoAccessModel> {
  const NoAccessModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  NoAccessModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => NoAccessModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
