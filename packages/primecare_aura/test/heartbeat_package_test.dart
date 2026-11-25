import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_aura/primecare_aura.dart';
void main(){test('heartbeat initial event and disposal retain behavior',() async {final container=ProviderContainer();addTearDown(container.dispose);final service=container.read(Provider((ref)=>AuraPulseService(ref)));final next=service.pulse.first;service.start();try{expect((await next).id,isNotEmpty);}finally{service.stop();}});}
