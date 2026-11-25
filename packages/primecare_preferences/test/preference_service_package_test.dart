import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_execution_gate/primecare_execution_gate.dart';
import 'package:primecare_preferences/primecare_preferences.dart';
void main(){TestWidgetsFlutterBinding.ensureInitialized();test('existing fixture favorites persist and toggle',() async {SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();final service=PreferenceService(prefs,ExecutionGateService());await service.toggleFavorite('fixture','item');expect(service.getFavorites('fixture'),['item']);await service.toggleFavorite('fixture','item');expect(service.getFavorites('fixture'),isEmpty);});}
