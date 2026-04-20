import 'package:primecare_core/flutter_core.dart';


class RolePermission {
  final String route;
  final String name;
  bool canRead;
  bool canWrite;

  RolePermission({
    required this.route,
    required this.name,
    this.canRead = false,
    this.canWrite = false,
  });

  RolePermission copyWith({
    bool? canRead,
    bool? canWrite,
  }) {
    return RolePermission(
      route: route,
      name: name,
      canRead: canRead ?? this.canRead,
      canWrite: canWrite ?? this.canWrite,
    );
  }
}

class RolePermissionsFormViewModel {
  final bool isLoading;
  final List<dynamic> roles;
  final List<dynamic> screens;
  final String? selectedRoleId;
  final Map<String, RolePermission> permissions; // Keyed by route
  final String? status;

  RolePermissionsFormViewModel({
    this.isLoading = false,
    this.roles = const [],
    this.screens = const [],
    this.selectedRoleId,
    this.permissions = const {},
    this.status,
  });

  RolePermissionsFormViewModel copyWith({
    bool? isLoading,
    List<dynamic>? roles,
    List<dynamic>? screens,
    String? selectedRoleId,
    Map<String, RolePermission>? permissions,
    String? status,
  }) {
    return RolePermissionsFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      roles: roles ?? this.roles,
      screens: screens ?? this.screens,
      selectedRoleId: selectedRoleId ?? this.selectedRoleId,
      permissions: permissions ?? this.permissions,
      status: status ?? this.status,
    );
  }
}

class RolePermissionsFormAdapter extends Notifier<RolePermissionsFormViewModel> {
  @override
  RolePermissionsFormViewModel build() {
    // Proactively load global roles/screens on build
    Future.microtask(() => loadInitialData());
    return RolePermissionsFormViewModel();
  }

  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true);
    final client = ref.read(apiClientProvider);

    try {
      final rolesRes = await client.get('/v1/identity/roles');
      final screensRes = await client.get('/v1/identity/screens');

      state = state.copyWith(
        isLoading: false,
        roles: rolesRes.data['data'] ?? [],
        screens: screensRes.data['data'] ?? [],
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, status: 'Error loading metadata');
    }
  }

  Future<void> loadPermissions(String roleId) async {
    state = state.copyWith(isLoading: true, selectedRoleId: roleId, status: null);
    final client = ref.read(apiClientProvider);

    try {
      final res = await client.get('/v1/identity/roles/$roleId/permissions');
      final List<dynamic> permsData = res.data['data'] ?? [];
      
      // Map base screens to state, overlaying existing permissions
      final Map<String, RolePermission> permsMap = {};
      for (var screen in state.screens) {
        final route = screen['route'];
        final name = screen['name'];
        final existing = permsData.firstWhere(
          (p) => p['screenRoute'] == route,
          orElse: () => null,
        );

        permsMap[route] = RolePermission(
          route: route,
          name: name,
          canRead: existing?['canRead'] ?? false,
          canWrite: existing?['canWrite'] ?? false,
        );
      }

      state = state.copyWith(isLoading: false, permissions: permsMap);
    } catch (e) {
      state = state.copyWith(isLoading: false, status: 'Error loading permissions');
    }
  }

  void toggleRead(String route, bool value) {
    final perms = Map<String, RolePermission>.from(state.permissions);
    if (perms.containsKey(route)) {
      perms[route] = perms[route]!.copyWith(canRead: value);
      state = state.copyWith(permissions: perms);
    }
  }

  void toggleWrite(String route, bool value) {
    final perms = Map<String, RolePermission>.from(state.permissions);
    if (perms.containsKey(route)) {
      perms[route] = perms[route]!.copyWith(canWrite: value);
      state = state.copyWith(permissions: perms);
    }
  }

  Future<bool> submit() async {
    if (state.selectedRoleId == null) return false;

    state = state.copyWith(isLoading: true);
    final telemetry = ref.read(executionGateProvider);
    final client = ref.read(apiClientProvider);

    telemetry.passGate(
      ExecutionGateCategory.domainApi,
      'Updating permissions for role: ${state.selectedRoleId}',
      metadata: {'roleId': state.selectedRoleId},
    );

    final result = await Result.guardFuture<bool>(() async {
      final payload = {
        'permissions': state.permissions.values.map((p) => {
          'screenRoute': p.route,
          'canRead': p.canRead,
          'canWrite': p.canWrite,
        }).toList(),
      };

      final response = await client.post('/v1/identity/roles/${state.selectedRoleId}/permissions', body: payload);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
        return false;
    });

    return result.fold(
      (success) {
        telemetry.passGate(ExecutionGateCategory.domainApi, 'Permissions updated successfully');
        state = state.copyWith(isLoading: false, status: 'Success');
        return true;
      },
      (error) {
        telemetry.failGate(ExecutionGateCategory.domainApi, 'Permission update failed', error: error);
        state = state.copyWith(isLoading: false, status: 'Error');
        return false;
      },
    );
  }
}

final rolePermissionsFormAdapterProvider =
    NotifierProvider<RolePermissionsFormAdapter, RolePermissionsFormViewModel>(() {
  return RolePermissionsFormAdapter();
});
