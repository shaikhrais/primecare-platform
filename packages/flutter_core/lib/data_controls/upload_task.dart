import 'package:flutter/foundation.dart';import 'data_controls_model.dart';
class UploadCancellation {bool cancelled=false;void cancel()=>cancelled=true;}
typedef UploadPort=Future<String> Function(String scope,String operationKey,List<UploadCandidate> files,UploadCancellation cancellation,ValueChanged<double> progress);
class UploadTask extends ChangeNotifier {final String scope;final UploadPolicy policy;final UploadPort? port;final bool retrySafe;String status='idle';double progress=0;String? receiptId;List<UploadCandidate> files=[];int _epoch=0,_selection=0;UploadCancellation _cancel=UploadCancellation();
 UploadTask(this.scope,this.policy,{this.port,this.retrySafe=false}){if(scope.trim().isEmpty||scope.length>1024)throw ArgumentError('invalid_upload_scope');}
 void choose(List<UploadCandidate> value){if(status=='disposed'||status=='uploading')throw StateError('upload_busy');files=[];status='idle';receiptId=null;progress=0;notifyListeners();final valid=validateFiles(value,policy);_epoch++;_selection++;files=valid;status='ready';notifyListeners();}
 Future<void> send()async{if(port==null||!['ready','error','cancelled'].contains(status)||status!='ready'&&!retrySafe)return;final generation=++_epoch;_cancel.cancel();_cancel=UploadCancellation();status='uploading';receiptId=null;progress=0;notifyListeners();try{final receipt=await port!(scope,'$scope:$_selection',List.unmodifiable(files),_cancel,(p){if(generation==_epoch&&p.isFinite&&p>=progress&&p<=1){progress=p;notifyListeners();}});if(generation!=_epoch)return;if(receipt.trim().isEmpty||receipt.length>256)throw StateError('missing_receipt');receiptId=receipt;progress=1;status='success';}catch(_){if(generation!=_epoch)return;status='error';}notifyListeners();}
 void cancel(){if(status!='uploading')return;_epoch++;_cancel.cancel();status='cancelled';notifyListeners();}
 @override void dispose(){_epoch++;_cancel.cancel();files=[];receiptId=null;progress=0;status='disposed';super.dispose();}
}
