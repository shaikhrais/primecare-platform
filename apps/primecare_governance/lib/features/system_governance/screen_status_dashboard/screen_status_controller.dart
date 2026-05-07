import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'screen_status_model.dart';

part 'screen_status_controller.g.dart';

@riverpod
class ScreenStatusController extends _$ScreenStatusController {
  @override
  ScreenStatusState build() {
    // Kick off data loading when the controller is initialized
    _loadStatusData();
    return const ScreenStatusState();
  }

  Future<void> _loadStatusData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/screen_status.json');
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      state = state.copyWith(statusData: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: 'Failed to load screen status data: $e', isLoading: false);
    }
  }
}
