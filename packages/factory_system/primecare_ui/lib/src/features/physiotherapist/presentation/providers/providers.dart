// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/physiotherapist_repository.dart';
import '../../domain/models/physiotherapist_state.dart';
import '../view_models/physiotherapist_notifier.dart';

final Provider<IPhysiotherapistRepository> physiotherapistRepositoryProvider =
    Provider<IPhysiotherapistRepository>((Ref ref) {
      return PhysiotherapistRepository();
    });

final NotifierProvider<PhysiotherapistNotifier, PhysiotherapistState>
physiotherapistDashboardProvider =
    NotifierProvider<PhysiotherapistNotifier, PhysiotherapistState>(() {
      return PhysiotherapistNotifier();
    });
