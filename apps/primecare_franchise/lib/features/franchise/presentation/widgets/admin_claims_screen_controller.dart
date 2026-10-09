// Governance - Category: controller | Purpose: Non-executable scaffold for AdminClaimsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final adminClaimsScreenControllerProvider =
    NotifierProvider<
      AdminClaimsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminClaimsScreenController();
    });

class AdminClaimsScreenController extends BaseScaffoldController {}
