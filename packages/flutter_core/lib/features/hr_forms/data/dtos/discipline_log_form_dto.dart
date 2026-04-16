class DisciplineLogFormDto {
  final Map<String, dynamic> rawData;

  DisciplineLogFormDto({required this.rawData});

  factory DisciplineLogFormDto.fromJson(Map<String, dynamic> json) {
    return DisciplineLogFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
