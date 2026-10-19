import 'package:primecare_models/primecare_models.dart';

class DocumentsModel extends BaseScreenState<DocumentsModel> {
  const DocumentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DocumentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DocumentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
