import 'package:flutter/foundation.dart';import 'data_controls_model.dart';
class UploadCancellation {bool cancelled=false;void cancel()=>cancelled=true;}
typedef UploadPort=Future<String> Function(String scope,String operationKey,List<UploadCandidate> files,UploadCancellation cancellation,ValueChanged<double> progress);
class UploadRemovalReceipt {final String receiptId;final bool removed;const UploadRemovalReceipt(this.receiptId,this.removed);}
class UploadReceiptState {final String scope,receiptId;final bool present;const UploadReceiptState(this.scope,this.receiptId,this.present);}
typedef UploadRemovalPort=Future<UploadRemovalReceipt> Function(String scope,String receiptId,String operationKey,UploadCancellation cancellation);
typedef UploadReceiptPort=Future<UploadReceiptState> Function(String scope,String receiptId,UploadCancellation cancellation);
class _Removal {final String receiptId,key;bool attempted=false,acknowledged=false;_Removal(this.receiptId,this.key);}
class UploadTask extends ChangeNotifier {final String scope;final UploadPolicy policy;final UploadPort? port;final bool retrySafe;final UploadRemovalPort? removalPort;final UploadReceiptPort? receiptPort;final bool removalRetrySafe;String status='idle';double progress=0;String? receiptId;List<UploadCandidate> files=[];int _epoch=0,_selection=0;UploadCancellation _cancel=UploadCancellation();_Removal? _removal;
 UploadTask(this.scope,UploadPolicy policy,{this.port,this.retrySafe=false,this.removalPort,this.receiptPort,this.removalRetrySafe=false}):policy=UploadPolicy(maxFiles:policy.maxFiles,maxBytes:policy.maxBytes,types:List<String>.unmodifiable(policy.types)){if(scope.trim().isEmpty||scope.length>1024)throw ArgumentError('invalid_upload_scope');}
 void choose(List<UploadCandidate> value){if(['disposed','uploading','removing'].contains(status)||_removal!=null)throw StateError('upload_busy');final valid=validateFiles(value,policy);_epoch++;_selection++;files=valid;receiptId=null;progress=0;status='ready';notifyListeners();}
 void removeSelection(int index){if(status!='ready'||index<0||index>=files.length)throw StateError('selection_unavailable');files=[for(var i=0;i<files.length;i++)if(i!=index)files[i]];_selection++;_epoch++;progress=0;status=files.isEmpty?'idle':'ready';notifyListeners();}
 Future<void> send()async{if(port==null||!['ready','error','cancelled'].contains(status)||status!='ready'&&!retrySafe)return;final generation=++_epoch;_cancel.cancel();_cancel=UploadCancellation();status='uploading';receiptId=null;progress=0;notifyListeners();if(generation!=_epoch)return;try{final receipt=await port!(scope,'$scope:$_selection',List.unmodifiable(files),_cancel,(p){if(generation==_epoch&&p.isFinite&&p>=progress&&p<=1){progress=p;notifyListeners();}});if(generation!=_epoch)return;if(receipt.trim().isEmpty||receipt.length>256)throw StateError('missing_receipt');receiptId=receipt;progress=1;status='success';}catch(_){if(generation!=_epoch)return;status='error';}notifyListeners();}
 Future<bool> _present(String receipt)async{final value=await receiptPort!(scope,receipt,_cancel);if(value.scope!=scope||value.receiptId!=receipt)throw StateError('invalid_removal_readback');return value.present;}
 Future<void> removeUpload()async{
  if(removalPort==null||receiptPort==null||!['success','remove-error'].contains(status)||receiptId==null)return;
  final generation=++_epoch;_cancel.cancel();_cancel=UploadCancellation();
  final pending=_removal??=_Removal(receiptId!,'$scope:remove:$_selection');status='removing';notifyListeners();
  try{
   if(pending.attempted){final exists=await _present(pending.receiptId);if(generation!=_epoch)return;if(!exists){_finishRemoval();return;}if(pending.acknowledged||!removalRetrySafe)throw StateError('removal_reconciliation_required');}
   pending.attempted=true;final ack=await removalPort!(scope,pending.receiptId,pending.key,_cancel);if(generation!=_epoch)return;
   if(ack.receiptId!=pending.receiptId||!ack.removed)throw StateError('invalid_removal_ack');pending.acknowledged=true;
   if(await _present(pending.receiptId))throw StateError('removal_readback_present');if(generation!=_epoch)return;_finishRemoval();
  }catch(_){if(generation!=_epoch)return;status='remove-error';notifyListeners();}
 }
 void _finishRemoval(){files=[];receiptId=null;progress=0;_removal=null;status='removed';notifyListeners();}
 void cancel(){if(status!='uploading')return;_epoch++;_cancel.cancel();status='cancelled';notifyListeners();}
 @override void dispose(){_epoch++;_cancel.cancel();files=[];receiptId=null;_removal=null;progress=0;status='disposed';super.dispose();}
}
