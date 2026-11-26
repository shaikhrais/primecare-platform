// Governance - Category: controller | Purpose: Non-executable scaffold for CfoFranchiseFinancialsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cfoFranchiseFinancialsScreenControllerProvider =
    NotifierProvider<
      CfoFranchiseFinancialsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoFranchiseFinancialsScreenController();
    });

class CfoFranchiseFinancialsScreenController extends BaseScaffoldController {}
