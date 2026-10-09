// Governance - Category: controller | Purpose: Non-executable scaffold for CtoAccessControlScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ctoAccessControlScreenControllerProvider =
    NotifierProvider<
      CtoAccessControlScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoAccessControlScreenController();
    });

class CtoAccessControlScreenController extends BaseScaffoldController {}
