import 'dart:convert';import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/data_controls.dart';

void main(){
 test('web/Dart range and contiguous-edit fixtures retain exact spans and literal runs',(){
  final fixture=jsonDecode(File('test/data_controls/rich-range-fixtures.json').readAsStringSync()) as Map;
  expect(fixture['offsetUnit'],'UTF-16; no surrogate-pair split');var checked=0;
  for(final sample in fixture['cases'] as List){var block=Map<String,Object?>.from(sample['initial'] as Map);
   for(final step in sample['steps'] as List){
    block=step['action']=='toggle'?toggleRichRange(block,step['start'] as int,step['end'] as int,step['style'] as String):replaceRichText(block,step['text'] as String);
    expect(block,step['expected']);expect(richRuns(block).map((r)=>r.toJson()).toList(),step['runs']);checked++;
   }
  }
  expect(checked,greaterThan(200));
 });
 test('invalid and split-surrogate spans reject without changing caller input',(){
  final block=<String,Object?>{'text':'a😀b','bold':false,'italic':false,'kind':'paragraph'};
  expect(()=>toggleRichRange(block,2,3,'bold'),throwsArgumentError);
  expect(()=>toggleRichRange(block,0,1,'link'),throwsArgumentError);
  expect(()=>validateDocument({'version':2,'blocks':[{...block,'marks':[{'start':0,'end':1,'bold':true,'italic':false,'html':'bad'}]}]}),throwsArgumentError);
  expect(block.containsKey('marks'),false);
 });
}
