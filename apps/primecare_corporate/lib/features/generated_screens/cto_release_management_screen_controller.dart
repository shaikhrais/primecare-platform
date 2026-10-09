// Governance - Category: controller | Purpose: Non-executable scaffold for CtoReleaseManagementScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ctoReleaseManagementScreenControllerProvider =
    NotifierProvider<
      CtoReleaseManagementScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoReleaseManagementScreenController();
    });

class CtoReleaseManagementScreenController extends BaseScaffoldController {}
