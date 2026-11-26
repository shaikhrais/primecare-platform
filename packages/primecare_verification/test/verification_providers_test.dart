import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_models/src/models/result.dart';
import 'package:primecare_verification/primecare_verification.dart';

void main() {
  test('report provider retains the supplied service identity and result', () async {
    final service = Provider<String>((ref) => 'fixture');
    final report = createVerificationReportProvider(
      service, (value) async => Success(<String,dynamic>{'source': value}));
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final result = await container.read(report.future);
    expect(result, isA<Success<Map<String,dynamic>>>());
    expect((result as Success<Map<String,dynamic>>).data['source'], 'fixture');
  });
}
