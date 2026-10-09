import 'package:primecare_models/primecare_models.dart';

class FileVerificationDashboardModel extends BaseScreenState<FileVerificationDashboardModel> {
  const FileVerificationDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FileVerificationDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FileVerificationDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
