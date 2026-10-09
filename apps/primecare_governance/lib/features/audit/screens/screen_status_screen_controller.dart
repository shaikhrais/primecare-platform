// Governance - Category: controller | Purpose: Non-executable scaffold for ScreenStatusScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final screenStatusScreenControllerProvider =
    NotifierProvider<
      ScreenStatusScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ScreenStatusScreenController();
    });

class ScreenStatusScreenController extends BaseScaffoldController {}
