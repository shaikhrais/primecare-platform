class ChemotherapyProtocolBuilderModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ChemotherapyProtocolBuilderModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ChemotherapyProtocolBuilderModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ChemotherapyProtocolBuilderModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
