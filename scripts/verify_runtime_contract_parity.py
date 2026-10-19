#!/usr/bin/env python3
"""Compare runtime contracts with the pinned pre-migration implementations."""
import argparse
import subprocess
from refactor_runtime_contracts import ROOT, CORE, original, take_class

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--dart',default='dart');args=parser.parse_args()
    package=ROOT/'packages/primecare_models'
    paths=[package/'test/runtime_auth_baseline.dart',package/'test/runtime_result_baseline.dart',package/'test/runtime_event_baseline.dart',package/'test/runtime_contract_parity_runner.dart']
    for path in paths:assert not path.exists(),path
    try:
        paths[0].write_text(take_class(original(CORE+'auth_service.dart'),'AuthState')[2])
        paths[1].write_text(original(CORE+'src/resilience/result.dart'))
        gate=original(CORE+'src/resilience/execution_gate_service.dart')
        event=gate[gate.index('/// Types of events'):take_class(gate,'ExecutionGateService')[0]]
        paths[2].write_text("import 'package:primecare_models/src/models/insight_impact.dart';\n"+event)
        paths[3].write_text(r'''import 'dart:convert';
import 'package:primecare_models/primecare_models.dart';
import 'runtime_auth_baseline.dart' as old;
import 'runtime_result_baseline.dart' as oldResult;
import 'runtime_event_baseline.dart' as oldEvent;
int cases = 0;
Object authTrace(dynamic state) => [state.isAuthenticated, state.isInitialized, state.token, state.role, state.tenantId, state.userName, state.userId, state.preferredLanguage];
void same(Object before, Object after) {
  if(jsonEncode(before)!=jsonEncode(after)) throw StateError('Contract changed: $before != $after');
  cases++;
}
Object eventTrace(dynamic event) => [event.id, (event.type as Enum).name, event.title, event.description, (event.impact as Enum).name, event.timestamp.toIso8601String(), event.isPredictive, event.metadata];
Object resultTrace(dynamic result) {
  Object? thrown;
  Object? value;
  try {value=result.getOrThrow();} catch(error){thrown=error.toString();}
  return [result.fold((dynamic value)=>['success',value], (Object error)=>['failure',error.toString()]), value, thrown];
}
Future<void> main() async {
  for(var bits=0;bits<256;bits++) {
    String? field(int offset) => bits & (1<<offset)==0 ? null : 'existing-$offset';
    final before=old.AuthState(isAuthenticated:bits&1!=0,isInitialized:bits&2!=0,token:field(2),role:field(3),tenantId:field(4),userName:field(5),userId:field(6),preferredLanguage:field(7));
    final after=AuthState(isAuthenticated:bits&1!=0,isInitialized:bits&2!=0,token:field(2),role:field(3),tenantId:field(4),userName:field(5),userId:field(6),preferredLanguage:field(7));
    same(authTrace(before),authTrace(after));
    same(authTrace(before.copyWith()),authTrace(after.copyWith()));
    same(authTrace(before.copyWith(isAuthenticated:false,isInitialized:false,token:null,role:null,tenantId:null,userName:null,userId:null,preferredLanguage:null)),authTrace(after.copyWith(isAuthenticated:false,isInitialized:false,token:null,role:null,tenantId:null,userName:null,userId:null,preferredLanguage:null)));
    same(authTrace(before.copyWith(isAuthenticated:true,isInitialized:true,token:'next-token',role:'next-role',tenantId:'next-tenant',userName:'next-name',userId:'next-user',preferredLanguage:'fr')),authTrace(after.copyWith(isAuthenticated:true,isInitialized:true,token:'next-token',role:'next-role',tenantId:'next-tenant',userName:'next-name',userId:'next-user',preferredLanguage:'fr')));
    if(after is! BaseAuthenticationState || after.copyWith() is! AuthState)throw StateError('Auth inheritance changed');
  }
  same(authTrace(old.AuthState()),authTrace(AuthState()));
  same(oldEvent.AuraEventType.values.map((e)=>e.name).toList(),AuraEventType.values.map((e)=>e.name).toList());
  same(oldEvent.ExecutionGateCategory.values.map((e)=>e.name).toList(),ExecutionGateCategory.values.map((e)=>e.name).toList());
  for(var index=0;index<AuraEventType.values.length;index++) {
    for(final impact in InsightImpact.values) {
      for(final predictive in [false,true]) {
        final metadata=<String,dynamic>{'existing':'value'};
        final timestamp=DateTime.utc(2026,1,1);
        final before=oldEvent.AuraEvent(id:'existing',type:oldEvent.AuraEventType.values[index],title:'Existing',description:'Original',impact:impact,timestamp:timestamp,isPredictive:predictive,metadata:metadata);
        final after=AuraEvent(id:'existing',type:AuraEventType.values[index],title:'Existing',description:'Original',impact:impact,timestamp:timestamp,isPredictive:predictive,metadata:metadata);
        same(eventTrace(before),eventTrace(after));
        if(!identical(after.metadata,metadata) || after is! BaseEntity<String>)throw StateError('Event ownership changed');
      }
    }
  }
  final windowStart=DateTime.now();
  final beforeStable=oldEvent.AuraEvent.stable();final afterStable=AuraEvent.stable();
  final windowEnd=DateTime.now();
  final beforeTrace=eventTrace(beforeStable) as List;final afterTrace=eventTrace(afterStable) as List;
  beforeTrace[5]='timestamp';afterTrace[5]='timestamp';same(beforeTrace,afterTrace);
  if(afterStable.timestamp.isBefore(windowStart)||afterStable.timestamp.isAfter(windowEnd))throw StateError('Stable event clock changed');
  for(final fails in [false,true]) {
    for(final fallback in [0,1,2]) {
      int compute(){if(fails)throw StateError('existing-failure');return 42;}
      int recover(Object error,StackTrace stack){if(fallback==2)throw StateError('fallback-failure');return 7;}
      same(resultTrace(oldResult.Result.guard<int>(compute,onError:fallback==0?null:recover)),resultTrace(Result.guard<int>(compute,onError:fallback==0?null:recover)));
      same(resultTrace(await oldResult.Result.guardFuture<int>(()async=>compute(),onError:fallback==0?null:recover)),resultTrace(await Result.guardFuture<int>(()async=>compute(),onError:fallback==0?null:recover)));
      Future<int> recoverAsync(Object error,StackTrace stack)async=>recover(error,stack);
      same(resultTrace(await oldResult.Result.guardFuture<int>(()async=>compute(),onError:fallback==0?null:recoverAsync)),resultTrace(await Result.guardFuture<int>(()async=>compute(),onError:fallback==0?null:recoverAsync)));
    }
  }
  final error=StateError('existing-error');
  if(!identical((Result.guard<int>(()=>throw error) as Failure<int>).error,error))throw StateError('Failure identity changed');
  final value=<String>[];
  if(!identical(Success(value).getOrThrow(),value))throw StateError('Success identity changed');
  same(resultTrace(const oldResult.Success<Object?>(null)),resultTrace(const Success<Object?>(null)));
  print('Runtime contract parity passed: $cases cases');
}
''')
        subprocess.run([args.dart,'run',str(paths[3].relative_to(package))],cwd=package,check=True)
    finally:
        for path in paths:path.unlink(missing_ok=True)
if __name__=='__main__':main()
