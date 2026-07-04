class ReceptionistVisitorsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ReceptionistVisitorsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ReceptionistVisitorsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ReceptionistVisitorsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
