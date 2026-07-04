class RegionalBdmLeadsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RegionalBdmLeadsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RegionalBdmLeadsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RegionalBdmLeadsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
