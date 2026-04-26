// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/03_D_physiotherapist_repository.dart';
import '../../domain/models/02_M_physiotherapist_state.dart';
import '../view_models/04_V_physiotherapist_notifier.dart';

final Provider<IPhysiotherapistRepository> physiotherapistRepositoryProvider =
    Provider<IPhysiotherapistRepository>((Ref ref) {
      return PhysiotherapistRepository();
    });

final NotifierProvider<PhysiotherapistNotifier, PhysiotherapistState>
physiotherapistDashboardProvider =
    NotifierProvider<PhysiotherapistNotifier, PhysiotherapistState>(() {
      return PhysiotherapistNotifier();
    });
