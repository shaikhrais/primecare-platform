import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_demo_user_management/primecare_demo_user_management.dart';
void main() { test('simulated controller returns fixture list without network', () async { final container=ProviderContainer(); addTearDown(container.dispose); final users=await container.read(userManagementProvider.future); expect(users.length,3); }); }
