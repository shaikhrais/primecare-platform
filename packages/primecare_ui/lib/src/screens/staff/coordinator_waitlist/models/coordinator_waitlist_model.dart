import 'package:primecare_models/primecare_models.dart';

class CoordinatorWaitlistModel extends BaseScreenState<CoordinatorWaitlistModel> {
  const CoordinatorWaitlistModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CoordinatorWaitlistModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CoordinatorWaitlistModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
