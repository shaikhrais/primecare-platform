class StitchMessaging00139Dto {
  final String id;
  final String type;
  final String title;
  final String status;
  
  StitchMessaging00139Dto.fromJson(Map<String, dynamic> json) 
    : id = json['id'] ?? '',
      type = json['type'] ?? '',
      title = json['title'] ?? '',
      status = json['status'] ?? '';
}
