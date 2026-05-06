import 'package:flutter_core/flutter_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'psw_dashboard_state.freezed.dart';

@freezed
abstract class PswDashboardState with _$PswDashboardState {
  const factory PswDashboardState({
    @Default(AsyncValue<PswDashboardData>.loading()) AsyncValue<PswDashboardData> dashboardData,
    @Default(AsyncValue<AuthState>.loading()) AsyncValue<AuthState> authState,
    @Default(false) bool isSyncing,
  }) = _PswDashboardState;
}
