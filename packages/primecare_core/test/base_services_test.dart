import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Service extends BaseResultService {}
class Scheduling extends BaseSchedulingService {}

void main() {
  test('inherited guard preserves result and recovery semantics', () async {
    final service = Service();
    expect((await service.guard(() => 42)).getOrThrow(), 42);
    final error = StateError('failed');
    final failure = await service.guard<int>(() async => throw error);
    expect(failure.getOrThrow, throwsA(same(error)));
    final recovered = await service.guard<int>(() => throw error,
      onError: (e, stack) async => 7);
    expect(recovered.getOrThrow(), 7);
    final inner = StateError('fallback');
    final failedFallback = await service.guard<int>(() => throw error,
      onError: (e, stack) => throw inner);
    expect(failedFallback.getOrThrow, throwsA(same(inner)));
  });

  test('scheduling conflict checks preserve overlap and availability rules', () {
    final service = Scheduling();
    Appointment appointment(int start, int end, {String staff = 's1', String? resource}) =>
      Appointment(id: 'a', patientName: 'Patient', staffId: staff, resourceId: resource,
        startTime: DateTime.utc(2026, 10, 10, start), endTime: DateTime.utc(2026, 10, 10, end));
    final existing = [appointment(9, 10, resource: 'r1')];
    expect(service.hasConflict(appointment(9, 10), existing, []), isTrue);
    expect(service.hasConflict(appointment(10, 11), existing, []), isFalse);
    expect(service.hasConflict(appointment(8, 11), existing, []), isTrue);
    expect(service.hasConflict(appointment(9, 10, staff: 's2'), existing, []), isFalse);
    expect(service.hasConflict(appointment(9, 10, staff: 's2', resource: 'r1'), existing, []), isTrue);
    for (final status in ResourceStatus.values) {
      expect(service.hasConflict(appointment(12, 13, resource: 'r1'), [],
        [InstitutionalResource(id: 'r1', name: 'Room', status: status)]),
        status != ResourceStatus.available);
    }
  });
}
