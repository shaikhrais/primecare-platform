import 'package:primecare_models/primecare_models.dart';

class ResponsivePreviewModel extends BaseScreenState<ResponsivePreviewModel> {
  const ResponsivePreviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ResponsivePreviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ResponsivePreviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
