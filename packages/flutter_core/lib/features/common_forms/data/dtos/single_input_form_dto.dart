class SingleInputFormDto {
  final Map<String, dynamic> rawData;

  SingleInputFormDto({required this.rawData});

  factory SingleInputFormDto.fromJson(Map<String, dynamic> json) {
    return SingleInputFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
