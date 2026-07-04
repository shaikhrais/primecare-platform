class ConfigurationVersionControlModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ConfigurationVersionControlModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ConfigurationVersionControlModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ConfigurationVersionControlModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
