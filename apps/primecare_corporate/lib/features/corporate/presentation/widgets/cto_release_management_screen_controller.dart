// Governance - Category: controller | Purpose: Non-executable scaffold for CtoReleaseManagementScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ctoReleaseManagementScreenControllerProvider =
    NotifierProvider<
      CtoReleaseManagementScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoReleaseManagementScreenController();
    });

class CtoReleaseManagementScreenController extends BaseScaffoldController {}
