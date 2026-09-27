class DataPrivacyMonitorModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const DataPrivacyMonitorModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  DataPrivacyMonitorModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return DataPrivacyMonitorModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
