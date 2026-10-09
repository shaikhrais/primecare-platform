import 'package:primecare_models/primecare_models.dart';

class AsynchronousConsultationInboxModel extends BaseScreenState<AsynchronousConsultationInboxModel> {
  const AsynchronousConsultationInboxModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AsynchronousConsultationInboxModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AsynchronousConsultationInboxModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
