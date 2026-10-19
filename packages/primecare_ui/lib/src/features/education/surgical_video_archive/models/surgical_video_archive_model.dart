import 'package:primecare_models/primecare_models.dart';

class SurgicalVideoArchiveModel extends BaseScreenState<SurgicalVideoArchiveModel> {
  const SurgicalVideoArchiveModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SurgicalVideoArchiveModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SurgicalVideoArchiveModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
