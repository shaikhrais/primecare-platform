import 'package:primecare_models/primecare_models.dart';

class ReleaseOperationsModel extends BaseScreenState<ReleaseOperationsModel> {
  const ReleaseOperationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReleaseOperationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReleaseOperationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
