import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/franchise_owner_state.dart';
import '../view_models/franchise_owner_view_model.dart';

final NotifierProvider<FranchiseOwnerViewModel, FranchiseOwnerState>
franchiseOwnerViewModelProvider =
    NotifierProvider<FranchiseOwnerViewModel, FranchiseOwnerState>(() {
      return FranchiseOwnerViewModel();
    });
