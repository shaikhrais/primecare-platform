import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_feature_stub/primecare_feature_stub.dart';
void main() { test('stub starts idle', () { final container = ProviderContainer(); addTearDown(container.dispose); expect(container.read(commonFeatureDataProvider).isLoading, isFalse); }); }
