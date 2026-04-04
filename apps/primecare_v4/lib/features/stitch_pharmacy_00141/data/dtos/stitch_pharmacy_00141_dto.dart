class StitchPharmacy00141Dto {
  final String id;
  final String type;
  final String title;
  final String status;
  
  StitchPharmacy00141Dto.fromJson(Map<String, dynamic> json) 
    : id = json['id'] ?? '',
      type = json['type'] ?? '',
      title = json['title'] ?? '',
      status = json['status'] ?? '';
}
