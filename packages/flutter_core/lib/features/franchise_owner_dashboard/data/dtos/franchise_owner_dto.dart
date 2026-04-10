class FranchiseOwnerDto {
  final List<dynamic> rawKpis;
  final List<dynamic> rawActivities;

  FranchiseOwnerDto({required this.rawKpis, required this.rawActivities});

  factory FranchiseOwnerDto.fromJson(Map<String, dynamic> json) {
    return FranchiseOwnerDto(
      rawKpis: json['kpis'] ?? [],
      rawActivities: json['activities'] ?? [],
    );
  }
}
