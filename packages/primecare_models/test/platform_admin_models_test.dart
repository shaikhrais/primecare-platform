import 'package:test/test.dart';
import 'package:primecare_models/primecare_models.dart';
void main(){
 final record={'id':'r','tenantId':null,'category':'services','code':'care','labels':{'en':'Care','es':'Cuidado','fr':'Soins'},'status':'active'};
 test('Localized master projections retain immutable labels',(){final model=AdminMasterRecord.fromJson(record);expect(model.label('es'),'Cuidado');expect(model.label('unknown'),'Care');expect(()=>model.labels['en']='Changed',throwsUnsupportedError);});
 test('Every reference requires all three languages',(){expect(()=>AdminMasterRecord.fromJson({...record,'labels':{'en':'Care'}}),throwsFormatException);});
 test('Reference status is canonical',(){expect(()=>AdminMasterRecord.fromJson({...record,'status':'paused'}),throwsFormatException);});
 test('Active monitoring counts cannot exceed totals',(){expect(()=>AdminPlatformSnapshot.fromJson({'sampledAt':'2026-10-11T00:00:00Z',for(final key in AdminPlatformSnapshot.metrics)key:0,'usersActive':1}),throwsFormatException);});
 test('Monitoring rejects negative counts',(){expect(()=>AdminPlatformSnapshot.fromJson({'sampledAt':'2026-10-11T00:00:00Z',for(final key in AdminPlatformSnapshot.metrics)key:0,'sessionsActive':-1}),throwsFormatException);});
}
