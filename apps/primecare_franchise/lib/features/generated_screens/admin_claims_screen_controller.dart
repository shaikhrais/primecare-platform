// Governance - Category: controller | Purpose: Non-executable scaffold for AdminClaimsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final adminClaimsScreenControllerProvider =
    NotifierProvider<
      AdminClaimsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminClaimsScreenController();
    });

class AdminClaimsScreenController extends BaseScaffoldController {}
