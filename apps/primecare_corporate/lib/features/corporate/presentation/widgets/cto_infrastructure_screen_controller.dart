// Governance - Category: controller | Purpose: Non-executable scaffold for CtoInfrastructureScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ctoInfrastructureScreenControllerProvider =
    NotifierProvider<
      CtoInfrastructureScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoInfrastructureScreenController();
    });

class CtoInfrastructureScreenController extends BaseScaffoldController {}
