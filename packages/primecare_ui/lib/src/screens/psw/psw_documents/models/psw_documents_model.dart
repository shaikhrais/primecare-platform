import 'package:primecare_models/primecare_models.dart';

class PswDocumentsModel extends BaseScreenState<PswDocumentsModel> {
  const PswDocumentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswDocumentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswDocumentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
