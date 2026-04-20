import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/franchise_owner_state.dart';
import '../view_models/franchise_owner_view_model.dart';

final NotifierProvider<FranchiseOwnerViewModel, FranchiseOwnerState>
franchiseOwnerViewModelProvider =
    NotifierProvider<FranchiseOwnerViewModel, FranchiseOwnerState>(() {
      return FranchiseOwnerViewModel();
    });
