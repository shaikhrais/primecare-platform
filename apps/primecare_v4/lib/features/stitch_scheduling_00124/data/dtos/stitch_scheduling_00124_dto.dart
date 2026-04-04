class StitchScheduling00124Dto {
  final String id;
  final String type;
  final String title;
  final String status;
  
  StitchScheduling00124Dto.fromJson(Map<String, dynamic> json) 
    : id = json['id'] ?? '',
      type = json['type'] ?? '',
      title = json['title'] ?? '',
      status = json['status'] ?? '';
}
