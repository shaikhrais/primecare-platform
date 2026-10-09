import 'package:primecare_models/primecare_models.dart';

class ConsentModel extends BaseScreenState<ConsentModel> {
  const ConsentModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ConsentModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ConsentModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
