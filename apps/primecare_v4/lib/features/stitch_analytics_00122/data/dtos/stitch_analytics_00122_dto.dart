class StitchAnalytics00122Dto {
  final String id;
  final String type;
  final String title;
  final String status;
  
  StitchAnalytics00122Dto.fromJson(Map<String, dynamic> json) 
    : id = json['id'] ?? '',
      type = json['type'] ?? '',
      title = json['title'] ?? '',
      status = json['status'] ?? '';
}
