// Host supplies the original authenticated API client.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_controller_base/src/controllers/base_dashboard_controller.dart';
import '../network/api_client.dart';
export 'package:primecare_controller_base/src/controllers/base_dashboard_controller.dart' show DashboardState, DashboardLoadResult, DashboardLoader;

abstract class BaseDashboardController<S extends DashboardState<S>>
    extends BaseDashboardControllerBase<S> {
  BaseDashboardController(
    Ref ref, {
    required S initialState,
    required String endpoint,
    DashboardLoader? loader,
  }) : super(ref, initialState: initialState, endpoint: endpoint,
           loader: loader ?? (() async {
             final response = await ref.read(apiClientProvider).get(endpoint);
             return DashboardLoadResult(
               isSuccess: response.isSuccess,
               data: response.data,
               error: response.error,
             );
           }));
}
