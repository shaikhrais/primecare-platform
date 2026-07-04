class ReceptionistCallsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ReceptionistCallsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ReceptionistCallsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ReceptionistCallsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
