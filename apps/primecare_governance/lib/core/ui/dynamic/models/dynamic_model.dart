import 'package:primecare_models/primecare_models.dart';

class DynamicModel extends BaseScreenState<DynamicModel> {
  const DynamicModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DynamicModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DynamicModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
