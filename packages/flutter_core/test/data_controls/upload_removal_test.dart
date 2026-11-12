import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/data_controls.dart';
const policy=UploadPolicy(maxFiles:2,maxBytes:100,types:['text/plain']);
const files=[UploadCandidate('a.txt',5,'text/plain','a'),UploadCandidate('b.txt',5,'text/plain','b')];
Future<UploadTask> uploaded({UploadRemovalPort? remove,UploadReceiptPort? read,bool safe=false})async{
 final task=UploadTask('actor-session',policy,port:(a,b,c,d,e)async=>'r1',retrySafe:true,removalPort:remove,receiptPort:read,removalRetrySafe:safe);
 task.choose(files);await task.send();return task;
}
void main(){
 test('remove local selections only before upload',()async{final task=UploadTask('actor-session',policy);task.choose(files);task.removeSelection(0);expect(task.files.single.name,'b.txt');task.removeSelection(0);expect(task.status,'idle');expect(()=>task.removeSelection(0),throwsStateError);task.dispose();});
 test('remove remote upload only after independent absence',()async{var present=true,writes=0,reads=0;final task=await uploaded(remove:(a,b,c,d)async{writes++;present=false;return UploadRemovalReceipt(b,true);},read:(a,b,c)async{reads++;return UploadReceiptState(a,b,present);});await task.removeUpload();expect(task.status,'removed');expect(task.receiptId,null);expect(task.files,isEmpty);expect(writes,1);expect(reads,1);task.dispose();});
 test('acknowledged write followed by read failure retries only the read',()async{var writes=0,reads=0;final task=await uploaded(remove:(a,b,c,d)async{writes++;return UploadRemovalReceipt(b,true);},read:(a,b,c)async{if(++reads==1)throw StateError('offline');return UploadReceiptState(a,b,false);});await task.removeUpload();expect(task.status,'remove-error');expect(task.receiptId,'r1');expect(task.files.length,2);expect(()=>task.choose(files),throwsStateError);await task.removeUpload();expect(task.status,'removed');expect(writes,1);task.dispose();});
 test('lost acknowledgement is reconciled without repeating delete',()async{var writes=0;final task=await uploaded(remove:(a,b,c,d)async{writes++;throw StateError('lost reply after commit');},read:(a,b,c)async=>UploadReceiptState(a,b,false));await task.removeUpload();await task.removeUpload();expect(task.status,'removed');expect(writes,1);task.dispose();});
 test('denied or unsafe uncertain mutation is never replayed',()async{var writes=0;final task=await uploaded(remove:(a,b,c,d)async{writes++;throw StateError('denied');},read:(a,b,c)async=>UploadReceiptState(a,b,true));await task.removeUpload();await task.removeUpload();expect(task.status,'remove-error');expect(writes,1);expect(task.receiptId,'r1');task.dispose();});
 test('declared idempotency reuses exact key; scope mismatch fails closed',()async{var writes=0,present=true;final keys=<String>[];final task=await uploaded(safe:true,remove:(a,b,c,d)async{keys.add(c);if(++writes==1)throw StateError('offline');present=false;return UploadRemovalReceipt(b,true);},read:(a,b,c)async=>UploadReceiptState(a,b,present));await task.removeUpload();await task.removeUpload();expect(task.status,'removed');expect(keys.first,keys.last);task.dispose();final wrong=await uploaded(remove:(a,b,c,d)async=>UploadRemovalReceipt(b,true),read:(a,b,c)async=>UploadReceiptState('foreign',b,false));await wrong.removeUpload();expect(wrong.status,'remove-error');expect(wrong.receiptId,'r1');wrong.dispose();});
 test('dispose suppresses late completion and unbound removal is inert',()async{final pending=Completer<UploadRemovalReceipt>();final task=await uploaded(remove:(a,b,c,d)=>pending.future,read:(a,b,c)async=>UploadReceiptState(a,b,false));final work=task.removeUpload();task.dispose();pending.complete(const UploadRemovalReceipt('r1',true));await work;expect(task.status,'disposed');final unbound=await uploaded();await unbound.removeUpload();expect(unbound.status,'success');unbound.dispose();});

 test('invalid replacement preserves retry identity and acknowledged receipt',()async{
  final keys=<String>[];var notifications=0;
  final task=UploadTask('actor-session',policy,retrySafe:true,port:(scope,key,value,cancel,report)async{keys.add(key);if(keys.length==1)throw StateError('offline');return 'r1';},removalPort:(a,b,c,d)async=>UploadRemovalReceipt(b,true),receiptPort:(a,b,c)async=>UploadReceiptState(a,b,false));
  task.choose(files);await task.send();task.addListener(()=>notifications++);
  for(final invalid in <List<UploadCandidate>>[[],[const UploadCandidate('large.txt',101,'text/plain','x')],[const UploadCandidate('bad.html',5,'text/html','x')]]){
   expect(()=>task.choose(invalid),throwsArgumentError);expect(task.status,'error');expect(task.files.map((file)=>file.name),['a.txt','b.txt']);expect(notifications,0);
  }
  await task.send();expect(keys[0],keys[1]);final before=notifications;
  expect(()=>task.choose([const UploadCandidate('../bad',5,'text/plain','x')]),throwsArgumentError);
  expect(task.status,'success');expect(task.receiptId,'r1');expect(task.progress,1);expect(task.files.map((file)=>file.name),['a.txt','b.txt']);expect(notifications,before);
  await task.removeUpload();expect(task.status,'removed');task.dispose();
 });
 test('valid replacement notifies one committed selection without an empty intermediate state',()async{
  final task=await uploaded(),observed=<String>[];task.addListener(()=>observed.add('${task.status}:${task.files.map((file)=>file.name).join(',')}'));
  task.choose([files.last]);expect(observed,['ready:b.txt']);expect(task.receiptId,null);expect(task.progress,0);task.dispose();
 });
 test('cancellation from upload notification prevents transport and retains retry selection',()async{
  var sends=0;final task=UploadTask('actor-session',policy,retrySafe:true,port:(a,b,c,d,e)async{ sends++;return 'r1';});task.choose(files);
  void cancelOnStart(){if(task.status=='uploading')task.cancel();}
  task.addListener(cancelOnStart);await task.send();expect(sends,0);expect(task.status,'cancelled');expect(task.files.map((file)=>file.name),['a.txt','b.txt']);
  task.removeListener(cancelOnStart);await task.send();expect(sends,1);expect(task.status,'success');task.dispose();
 });
}
