import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/features/user_management/controllers/user_controller.dart';
import 'package:primecare_governance/features/user_management/models/user.dart';
import 'package:primecare_governance/features/user_management/services/user_service.dart';

class MockUserManagementService extends Mock implements UserManagementService {}

void main() {
  late MockUserManagementService mockService;
  late ProviderContainer container;

  setUp(() {
    mockService = MockUserManagementService();
    container = ProviderContainer(
      overrides: [
        userServiceProvider.overrideWithValue(mockService),
      ],
    );
  });

  test('UserController fetches users on initialization', () async {
    final users = [User(id: '1', name: 'Test User', email: 'test@example.com', role: 'admin')];
    
    when(() => mockService.fetchUsers()).thenAnswer((_) async => users);

    // Trigger build
    await container.read(userControllerProvider.future);

    expect(container.read(userControllerProvider).value, users);
    verify(() => mockService.fetchUsers()).called(1);
  });
}
