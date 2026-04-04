class StitchMessaging00131Dto {
  final String id;
  final String type;
  final String title;
  final String status;
  
  StitchMessaging00131Dto.fromJson(Map<String, dynamic> json) 
    : id = json['id'] ?? '',
      type = json['type'] ?? '',
      title = json['title'] ?? '',
      status = json['status'] ?? '';
}
