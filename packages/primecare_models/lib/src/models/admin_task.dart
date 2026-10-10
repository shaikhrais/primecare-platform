import 'base_entity.dart';

/// Shared role-task data describes workflows; server policy grants access.
abstract class BaseRoleTask extends BaseEntity<String> {
  final String titleKey, descriptionKey, operation;
  const BaseRoleTask({required super.id,required this.titleKey,required this.descriptionKey,required this.operation});
}
class AdminTask extends BaseRoleTask {
  const AdminTask({required super.id,required super.titleKey,required super.descriptionKey,required super.operation});
  factory AdminTask.fromJson(Map<String,dynamic> data) {
    final id=data['id'];
    if(data.length!=4 || data.keys.any((key)=>!['id','titleKey','descriptionKey','operation'].contains(key)) || id is! String || !RegExp(r'^[a-z][a-z-]*$').hasMatch(id) || data['titleKey']!='task.$id.title' || data['descriptionKey']!='task.$id.description' || !['workspace.read','accounts.create','accounts.update','audit.read','language.select'].contains(data['operation'])) throw const FormatException('Invalid Admin task definition');
    return AdminTask(id:id,titleKey:data['titleKey'] as String,descriptionKey:data['descriptionKey'] as String,operation:data['operation'] as String);
  }
}
