import 'package:primecare_models/primecare_models.dart';

class SocialMediaModel extends BaseScreenState<SocialMediaModel> {
  const SocialMediaModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SocialMediaModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SocialMediaModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
