class ApproveFranchiseDisclosureFormDto {
  final Map<String, dynamic> rawData;

  ApproveFranchiseDisclosureFormDto({required this.rawData});

  factory ApproveFranchiseDisclosureFormDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return ApproveFranchiseDisclosureFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
