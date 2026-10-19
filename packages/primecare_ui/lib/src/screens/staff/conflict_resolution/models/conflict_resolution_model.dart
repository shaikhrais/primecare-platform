import 'package:primecare_models/primecare_models.dart';

class ConflictResolutionModel extends BaseScreenState<ConflictResolutionModel> {
  const ConflictResolutionModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ConflictResolutionModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ConflictResolutionModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
