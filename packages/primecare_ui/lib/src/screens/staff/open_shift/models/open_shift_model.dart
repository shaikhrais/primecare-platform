import 'package:primecare_models/primecare_models.dart';

class OpenShiftModel extends BaseScreenState<OpenShiftModel> {
  const OpenShiftModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OpenShiftModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OpenShiftModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
