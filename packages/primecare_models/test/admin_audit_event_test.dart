import 'package:test/test.dart';
import 'package:primecare_models/primecare_models.dart';

void main() {
  final event = <String,dynamic>{'id':'event','actor':'admin','target':'user','action':'account_updated','createdAt':'2026-10-10T12:00:00Z','before':{'role':'client'},'after':{'role':'rmt','status':'inactive'}};
  test('Audit entity accepts only account projection and immutable states', () {
    final model=AdminAuditEvent.fromJson(event);
    expect(model,isA<BaseEntity<String>>());expect(model.after['role'],'rmt');
    expect(()=>model.after['role']='admin',throwsUnsupportedError);
  });
  test('Audit entity rejects sensitive fields and invalid dates', () {
    expect(()=>AdminAuditEvent.fromJson({...event,'after':{'password_hash':'secret'}}),throwsFormatException);
    expect(()=>AdminAuditEvent.fromJson({...event,'createdAt':'invalid'}),throwsFormatException);
    expect(()=>AdminAuditEvent.fromJson({...event,'action':'unsupported'}),throwsFormatException);
  });
}
