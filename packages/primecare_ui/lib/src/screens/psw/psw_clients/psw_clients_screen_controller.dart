import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyClientsScreenState extends DashboardState<MyClientsScreenState> {
  MyClientsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  MyClientsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => MyClientsScreenState(isLoading: isLoading, error: error, data: data);
}

class MyClientsScreenController
    extends BaseDashboardController<MyClientsScreenState> {
  MyClientsScreenController(Ref ref)
    : super(
        ref,
        initialState: MyClientsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/patient-profile',
      );
}

final psw_clientsControllerProvider =
    StateNotifierProvider<MyClientsScreenController, MyClientsScreenState>((
      ref,
    ) {
      return MyClientsScreenController(ref);
    });
