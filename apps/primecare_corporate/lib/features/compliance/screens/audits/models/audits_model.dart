import 'package:primecare_models/primecare_models.dart';

class AuditsModel extends BaseScreenState<AuditsModel> {
  const AuditsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AuditsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AuditsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
