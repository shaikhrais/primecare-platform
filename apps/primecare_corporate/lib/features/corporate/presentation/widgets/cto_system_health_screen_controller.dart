// Governance - Category: controller | Purpose: Non-executable scaffold for CtoSystemHealthScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ctoSystemHealthScreenControllerProvider =
    NotifierProvider<
      CtoSystemHealthScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoSystemHealthScreenController();
    });

class CtoSystemHealthScreenController extends BaseScaffoldController {}
