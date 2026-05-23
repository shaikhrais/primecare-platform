// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonFeatureState {
  final bool isLoading;
  CommonFeatureState({this.isLoading = false});
}

class CommonFeatureAdapter extends Notifier<CommonFeatureState> {
  @override
  CommonFeatureState build() {
    return CommonFeatureState();
  }
}

final commonFeatureDataProvider =
    NotifierProvider<CommonFeatureAdapter, CommonFeatureState>(
      CommonFeatureAdapter.new,
    );
