import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/role_data_repository.dart';
import '../data/role_data_model.dart';

final roleDataRepositoryProvider = Provider((ref) => RoleDataRepository());

final roleHydrationProvider = FutureProvider.family<RoleDataModel, String>((ref, roleId) {
  final repository = ref.read(roleDataRepositoryProvider);
  return repository.fetchRoleData(roleId);
});
