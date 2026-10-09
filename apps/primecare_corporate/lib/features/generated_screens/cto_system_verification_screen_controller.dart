// Governance - Category: controller | Purpose: Non-executable scaffold for CtoSystemVerificationScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ctoSystemVerificationScreenControllerProvider =
    NotifierProvider<
      CtoSystemVerificationScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoSystemVerificationScreenController();
    });

class CtoSystemVerificationScreenController extends BaseScaffoldController {}
