// Governance - Category: controller | Purpose: Non-executable scaffold for PswPatientProfileScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswPatientProfileScreenControllerProvider =
    NotifierProvider<
      PswPatientProfileScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswPatientProfileScreenController();
    });

class PswPatientProfileScreenController extends BaseScaffoldController {}
