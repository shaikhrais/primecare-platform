// Governance - Category: controller | Purpose: Non-executable scaffold for ScreenStatusScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final screenStatusScreenControllerProvider =
    NotifierProvider<
      ScreenStatusScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ScreenStatusScreenController();
    });

class ScreenStatusScreenController extends BaseScaffoldController {}
