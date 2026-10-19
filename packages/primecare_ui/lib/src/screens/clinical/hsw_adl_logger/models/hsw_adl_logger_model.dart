import 'package:primecare_models/primecare_models.dart';

class HswAdlLoggerModel extends BaseScreenState<HswAdlLoggerModel> {
  const HswAdlLoggerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HswAdlLoggerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HswAdlLoggerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
