import 'dart:convert';import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/data_controls.dart';

void main(){
 test('web/Dart range and contiguous-edit fixtures retain exact spans and literal runs',(){
  final fixture=jsonDecode(File('test/data_controls/rich-range-fixtures.json').readAsStringSync()) as Map;
  expect(fixture['offsetUnit'],'UTF-16; no surrogate-pair split');var checked=0;
  for(final sample in fixture['cases'] as List){var block=Map<String,Object?>.from(sample['initial'] as Map);
   for(final step in sample['steps'] as List){
    final edit=step['edit'];
    block=step['action']=='toggle'?toggleRichRange(block,step['start'] as int,step['end'] as int,step['style'] as String):replaceRichText(block,step['text'] as String,edit is Map?RichTextEdit(edit['start'] as int,edit['end'] as int):null);
    expect(block,step['expected']);expect(richRuns(block).map((r)=>r.toJson()).toList(),step['runs']);checked++;
   }
  }
  expect(checked,greaterThan(200));
 });
 test('selection context resolves repeated-character insertions and forward/backward deletion',(){
  final hint=inferRichEdit('aaaa','aaaaa',0,0,1)!;expect(hint.start,0);expect(hint.end,0);
  expect(inferRichEdit('aaaa','aaa',2,2,1)!.start,1);expect(inferRichEdit('aaaa','aaa',2,2,2)!.start,2);
  expect(inferRichEdit('a😀b','ab',3,3,1)!.start,1);
 });
 test('invalid and split-surrogate spans reject without changing caller input',(){
  final block=<String,Object?>{'text':'a😀b','bold':false,'italic':false,'kind':'paragraph'};
  expect(()=>toggleRichRange(block,2,3,'bold'),throwsArgumentError);
  expect(()=>toggleRichRange(block,0,1,'link'),throwsArgumentError);
  expect(()=>validateDocument({'version':2,'blocks':[{...block,'marks':[{'start':0,'end':1,'bold':true,'italic':false,'html':'bad'}]}]}),throwsArgumentError);
  expect(block.containsKey('marks'),false);
 });
}
