import 'package:test/test.dart';
import 'package:primecare_models/primecare_models.dart';

void main() {
  final definition=<String,dynamic>{'id':'create','titleKey':'task.create.title','descriptionKey':'task.create.description','operation':'accounts.create'};
  test('Admin task uses shared identity and role-task contracts', () {
    final task=AdminTask.fromJson(definition);expect(task,isA<BaseEntity<String>>());expect(task,isA<BaseRoleTask>());expect(task.operation,'accounts.create');
  });
  test('Task metadata rejects inconsistent keys, undeclared operations and extra fields', () {
    expect(()=>AdminTask.fromJson({...definition,'titleKey':'task.other.title'}),throwsFormatException);
    expect(()=>AdminTask.fromJson({...definition,'operation':'tenant.delete'}),throwsFormatException);
    expect(()=>AdminTask.fromJson({...definition,'permission':'global'}),throwsFormatException);
  });
}
