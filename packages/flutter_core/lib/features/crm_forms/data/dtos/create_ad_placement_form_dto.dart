class CreateAdPlacementFormDto {
  final Map<String, dynamic> rawData;

  CreateAdPlacementFormDto({
    required this.rawData,
  });

  factory CreateAdPlacementFormDto.fromJson(Map<String, dynamic> json) {
    return CreateAdPlacementFormDto(
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
