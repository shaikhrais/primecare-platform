class PublicHealthAlertBroadcasterModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PublicHealthAlertBroadcasterModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PublicHealthAlertBroadcasterModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PublicHealthAlertBroadcasterModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
