#!/usr/bin/env python3
"""Compare moved Flutter services/providers with their original implementations."""
import argparse
import subprocess
from refactor_runtime_contracts import ROOT, CORE, original

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--flutter',default='flutter');args=parser.parse_args()
    package=ROOT/'packages/flutter_core'
    names=['aura_command_service','intelligence_service','aura_providers','aura_pulse_service']
    paths=[package/'lib'/('runtime_'+name+'_baseline.dart') for name in names]
    runner=package/'test/runtime_flutter_parity_runner.dart'
    paths.append(runner)
    for path in paths:assert not path.exists(),path
    try:
        for name,path in zip(names,paths):path.write_text(original(CORE+name+'.dart'))
        runner.write_text(r'''import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/src/controllers/base_value_notifier.dart';
import 'package:flutter_core/src/application/services/base_business_service.dart';
import 'package:flutter_core/runtime_aura_command_service_baseline.dart' as oldCommand;
import 'package:flutter_core/runtime_intelligence_service_baseline.dart' as oldIntelligence;
import 'package:flutter_core/runtime_aura_providers_baseline.dart' as oldProviders;
import 'package:flutter_core/runtime_aura_pulse_service_baseline.dart' as oldPulse;

class RecordingGate extends ExecutionGateService {
  final events=<Object>[];
  bool reject=false;
  @override void passGate(ExecutionGateCategory category,String message,{bool silent=false,Map<String,dynamic>? metadata}) {
    events.add(['pass',category.name,message,silent,metadata]);
    if(reject)throw StateError('fixture telemetry rejection');
  }
  @override void failGate(ExecutionGateCategory category,String message,{Object? error,StackTrace? stackTrace,Map<String,dynamic>? metadata}) {
    events.add(['fail',category.name,message,error?.toString(),stackTrace!=null,metadata]);
  }
}
Object intentTrace(AuraIntent intent) => [intent.id.replaceFirst(RegExp(r'\d+$'),'CLOCK'),intent.rawQuery,intent.title,intent.description,intent.confidence,[for(final action in intent.actions)[action.type.name,action.target,action.params]]];
void equivalent(Object? before,Object? after) => expect(jsonEncode(after),jsonEncode(before));
void main() {
  test('all command keywords, precedence and suggestions match original',(){
    final before=oldCommand.AuraCommandService();final after=AuraCommandService();
    final keywords=['reassign','schedule','move','snooze','quiet','mute','revenue','billing','finance','staff','resource','nurses','occupancy','ward','bed','icu','report','trend','performance','how is'];
    final queries=<String>['',' unknown-input ', 'Remove to/from resource', ...keywords, ...keywords.map((e)=>e.toUpperCase()), for(final first in keywords)for(final second in keywords)'$first $second'];
    for(final query in queries) {
      final start=DateTime.now().millisecondsSinceEpoch;
      final first=before.processQuery(query).getOrThrow();final second=after.processQuery(query).getOrThrow();
      final end=DateTime.now().millisecondsSinceEpoch;
      equivalent(intentTrace(first),intentTrace(second));
      final stamp=int.parse(second.id.split('_').last);
      expect(stamp, inInclusiveRange(start,end));
    }
    for(final context in <String?>[null,'','finance','CFO','staff','COO','scheduler','institutional','unknown','finance staff','staff scheduler','institutional finance'])equivalent(before.getSuggestions(context:context),after.getSuggestions(context:context));
    print('Aura command parity passed: ${queries.length + 12} cases');
  });
  test('Aura scalar notifiers keep defaults, updates and nullable boundaries',(){
    final before=ProviderContainer();final after=ProviderContainer();
    addTearDown(before.dispose);addTearDown(after.dispose);
    equivalent(before.read(oldProviders.auraContextProvider),after.read(auraContextProvider));
    equivalent(before.read(oldProviders.auraActiveVisualizationProvider),after.read(auraActiveVisualizationProvider));
    equivalent(before.read(oldProviders.auraSnoozeProvider),after.read(auraSnoozeProvider));
    equivalent(before.read(oldProviders.auraQueryProvider),after.read(auraQueryProvider));
    expect(before.read(oldProviders.auraPulseEventProvider),isNull);expect(after.read(auraPulseEventProvider),isNull);
    expect(after.read(auraContextProvider.notifier),isA<BaseValueNotifier<String?>>());
    for(final value in <String?>['existing','',null]) {
      before.read(oldProviders.auraContextProvider.notifier).update(value);after.read(auraContextProvider.notifier).update(value);
      equivalent(before.read(oldProviders.auraContextProvider),after.read(auraContextProvider));
    }
    for(final value in [true,false,true]) {
      before.read(oldProviders.auraActiveVisualizationProvider.notifier).update(value);after.read(auraActiveVisualizationProvider.notifier).update(value);
      before.read(oldProviders.auraSnoozeProvider.notifier).update(value);after.read(auraSnoozeProvider.notifier).update(value);
      equivalent(before.read(oldProviders.auraActiveVisualizationProvider),after.read(auraActiveVisualizationProvider));
      equivalent(before.read(oldProviders.auraSnoozeProvider),after.read(auraSnoozeProvider));
    }
    for(final value in ['existing','', 'next']) {
      before.read(oldProviders.auraQueryProvider.notifier).update(value);after.read(auraQueryProvider.notifier).update(value);
      equivalent(before.read(oldProviders.auraQueryProvider),after.read(auraQueryProvider));
    }
    final event=AuraEvent.stable();
    before.read(oldProviders.auraPulseEventProvider.notifier).update(event);after.read(auraPulseEventProvider.notifier).update(event);
    expect(after.read(auraPulseEventProvider),same(event));expect(before.read(oldProviders.auraPulseEventProvider),same(event));
    expect(()=>(after.read(auraPulseEventProvider.notifier) as dynamic).update(null),throwsA(isA<TypeError>()));
    expect(()=>(before.read(oldProviders.auraPulseEventProvider.notifier) as dynamic).update(null),throwsA(isA<TypeError>()));
  });
  test('pulse start and stop retain stream and telemetry behavior',() async {
    final gate=RecordingGate();final container=ProviderContainer(overrides:[executionGateProvider.overrideWithValue(gate)]);
    addTearDown(container.dispose);
    final before=container.read(Provider((ref)=>oldPulse.AuraPulseService(ref)));
    final after=container.read(Provider((ref)=>AuraPulseService(ref)));
    final first=before.pulse.first;before.start();final firstEvent=await first;
    final trace=List<Object>.from(gate.events);gate.events.clear();
    final second=after.pulse.first;after.start();final secondEvent=await second;
    equivalent(trace,gate.events);expect(secondEvent.id,firstEvent.id);expect(secondEvent.type,firstEvent.type);expect(secondEvent.impact,firstEvent.impact);
    final beforeClosed=before.pulse.drain<void>();final afterClosed=after.pulse.drain<void>();
    before.stop();after.stop();await beforeClosed;await afterClosed;
  });
  testWidgets('intelligence guard, output and telemetry remain identical',(tester) async {
    var cases=0;
    for(final role in ['admin','facility_manager','other']) {
      for(final values in <List<double>>[[],[10],[10,20],[20,10],[10,10],[0,10]]) {
        for(final reject in [false,true]) {
          final beforeGate=RecordingGate()..reject=reject;final afterGate=RecordingGate()..reject=reject;
          final metrics=DashboardMetrics(kpis:{},insights:[],charts:values.isEmpty?[]:[AnalyticsChart(id:'existing',title:'Revenue',type:ChartType.line,dataPoints:[for(final value in values)DataPoint(label:'existing',value:value)])],recentActivity:[for(var i=0;i<6;i++)ActivityItem(id:'$i',title:'Existing',subtitle:'Original',timestamp:DateTime.utc(2026))]);
          final before=oldIntelligence.IntelligenceService(beforeGate);final after=IntelligenceService(afterGate);
          expect(after,isA<BaseGuardedService>());expect(after.telemetry,same(afterGate));
          final first=before.generateInsights(role,metrics);final second=after.generateInsights(role,metrics);
          await tester.pump(const Duration(milliseconds:800));
          equivalent((await first).getOrThrow().map((e)=>e.toJson()).toList(),(await second).getOrThrow().map((e)=>e.toJson()).toList());
          equivalent(beforeGate.events,afterGate.events);cases++;
        }
      }
    }
    print('Intelligence parity passed: $cases cases');
  });
}
''')
        subprocess.run([args.flutter,'test',str(runner.relative_to(package))],cwd=package,check=True)
    finally:
        for path in paths:path.unlink(missing_ok=True)
if __name__=='__main__':main()
