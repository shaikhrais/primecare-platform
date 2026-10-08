import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_clinic/features/psw/screens/psw_notifications_screen.dart';

class FakeOwnNotifications implements OwnNotificationsRepository {
  final responses = <ApiResponse>[];
  @override
  Future<ApiResponse> load() async => responses.removeAt(0);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final records in [
    <Map<String, dynamic>>[
      {'id': 'notification'},
    ],
    <Map<String, dynamic>>[],
  ]) {
    test(
      '401 then retry clears stale error for ${records.isEmpty ? "empty" : "nonempty"} owned list',
      () async {
        final repository = FakeOwnNotifications()
          ..responses.addAll([
            ApiResponse(data: <String, dynamic>{}, statusCode: 401, error: 'Session expired'),
            ApiResponse(data: records, statusCode: 200),
          ]);
        final container = ProviderContainer(
          overrides: [
            ownNotificationsRepositoryProvider.overrideWithValue(repository),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(
          pswNotificationsProvider,
          (_, __) {},
        );
        addTearDown(subscription.close);
        await Future<void>.delayed(Duration.zero);
        expect(
          container.read(pswNotificationsProvider).error,
          'Session expired',
        );
        expect(container.read(pswNotificationsProvider).hasData, false);
        await container.read(pswNotificationsProvider.notifier).refreshData();
        final state = container.read(pswNotificationsProvider);
        expect(state.error, isNull);
        expect(state.isLoading, false);
        expect(state.hasData, records.isNotEmpty);
      },
    );
  }
}
