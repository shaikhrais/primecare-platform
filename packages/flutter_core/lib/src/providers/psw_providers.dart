// Existing provider identity and authenticated service binding.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_models/src/models/psw_models.dart';
import 'package:primecare_models/src/models/result.dart';
import 'package:primecare_psw/src/providers/psw_providers.dart';
import '../services/psw_service.dart';

final pswDashboardProvider = FutureProvider.autoDispose<Result<PswDashboardData>>((ref) =>
  loadPswDashboard(ref, (ref) => ref.watch(pswServiceProvider).getDashboardData));
