import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/user.dart';
import 'services/user_service.dart';
import '../../../core/network/dio_provider.dart';

final userServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final api = UserApiService(dio);
  return UserManagementService(api);
});

class UserController extends AsyncNotifier<List<User>> {
  bool _hasMore = true;

  @override
  Future<List<User>> build() async {
    return ref.read(userServiceProvider).fetchUsers();
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;
    
    final service = ref.read(userServiceProvider);
    final moreUsers = await service.fetchUsers(); // In real app, pass _currentPage
    
    if (moreUsers.isEmpty) {
      _hasMore = false;
      return;
    }

    final previousUsers = state.value ?? [];
    state = AsyncValue.data([...previousUsers, ...moreUsers]);
  }

  Future<void> addUser(User user) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // final service = ref.read(userServiceProvider);
      // service._api.createUser(user); // Real call
      final currentUsers = state.value ?? [];
      return [...currentUsers, user];
    });
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(userServiceProvider).fetchUsers());
  }
}

final userControllerProvider = AsyncNotifierProvider<UserController, List<User>>(UserController.new);
