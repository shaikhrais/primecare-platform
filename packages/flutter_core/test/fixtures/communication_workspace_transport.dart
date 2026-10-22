// Isolated client test fixture. Never imported by production code.
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/communications/communication_core.dart';

Map<String,Object?> clone(Map<String,Object?> value) => (jsonDecode(jsonEncode(value)) as Map).cast<String,Object?>();
DioException denied(int? status) {
 final options=RequestOptions(path:'/synthetic-communication');
 return DioException(requestOptions:options,response:status==null?null:Response(requestOptions:options,statusCode:status),message:'private provider detail');
}
class FixtureTransport implements CommunicationTransport {
 Map<String,Object?> record={'id':'thread','tenantId':'tenant-a','version':1,'kind':'conversation','members':['alice','bob'],'messages':<Object?>[],'readThrough':<String,Object?>{},'calls':<Object?>[]};
 final requests=<Map<String,Object?>>[];
 final receipts=<String,Map<String,Object?>>{};
 Object? nextFailure;
 bool loseSendReceipt=false;
 Completer<Map<String,Object?>>? pendingRead;
 Uint8List png=Uint8List.fromList([137,80,78,71,13,10,26,10]);
 @override Future<Map<String,Object?>> execute(String channel,Map<String,Object?> input) async {
  final request=Map<String,Object?>.from(input);requests.add({'channel':channel,...request});
  for(final field in ['actor','actorId','tenantId','roles']){expect(request.containsKey(field),false);}
  final error=nextFailure;nextFailure=null;if(error!=null)throw error;
  if(channel=='picture'){
   if(request['action']=='upload')return {'id':'picture','tenantId':'tenant-a','threadId':record['id'],'mediaType':'image/png','size':(request['bytes'] as Uint8List).length,'status':'clean'};
   return {'bytes':Uint8List.fromList(png),'mediaType':'image/png'};
  }
  switch(request['action']){
   case 'inbox':return {'items':[clone(record)]};
   case 'read':
    final waiting=pendingRead;pendingRead=null;
    if(waiting!=null)return waiting.future;
    return clone(record);
   case 'create':
    final createdReceipt=receipts[request['key']];if(createdReceipt!=null)return createdReceipt;
    record={...record,'id':request['id'],'members':request['members'],'businessReference':request['businessReference'],'version':1,'messages':<Object?>[]};
    break;
   case 'send':
    final sentReceipt=receipts[request['key']];if(sentReceipt!=null)return sentReceipt;
    if(request['version']!=record['version'])throw denied(409);
    (record['messages'] as List).add({'id':request['key'],'text':request['text'],'authorId':'alice','pictureIds':request['pictureIds'],'sequence':(record['messages'] as List).length+1});
    record['version']=(record['version'] as int)+1;
    break;
   case 'mark_read':
    final readReceipt=receipts[request['key']];if(readReceipt!=null)return readReceipt;
    if(request['version']!=record['version'])throw denied(409);
    (record['readThrough'] as Map)['alice']=request['sequence'];record['version']=(record['version'] as int)+1;
    break;
   default:throw StateError('Unsupported synthetic action');
  }
  final result=<String,Object?>{'id':record['id'],'version':record['version']};receipts[request['key'] as String]=result;
  if(request['action']=='send'&&loseSendReceipt){loseSendReceipt=false;throw denied(null);}
  return result;
 }
}

