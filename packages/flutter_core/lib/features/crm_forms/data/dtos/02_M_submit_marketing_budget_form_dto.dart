// Layer: 02_MODELS_FOUNDATION
class SubmitMarketingBudgetFormDto {
  final String? id;
  final String? campaignName;
  final num? totalBudget;
  final String? startDate;
  final String? endDate;
  final String? platform;
  final String? details;

  SubmitMarketingBudgetFormDto({
    this.id,
    this.campaignName,
    this.totalBudget,
    this.startDate,
    this.endDate,
    this.platform,
    this.details,
  });

  factory SubmitMarketingBudgetFormDto.fromJson(Map<String, dynamic> json) {
    return SubmitMarketingBudgetFormDto(
      id: json['id'] as String?,
      campaignName: json['campaignName'] as String?,
      totalBudget: json['totalBudget'] as num?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      platform: json['platform'] as String?,
      details: json['details'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'campaignName': campaignName,
      'totalBudget': totalBudget,
      'startDate': startDate,
      'endDate': endDate,
      'platform': platform,
      'details': details,
    };
  }
}
