class RegionalBdmCompetitorNotesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RegionalBdmCompetitorNotesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RegionalBdmCompetitorNotesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RegionalBdmCompetitorNotesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
