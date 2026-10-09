// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyProfileScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final familyProfileScreenControllerProvider =
    NotifierProvider<
      FamilyProfileScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyProfileScreenController();
    });

class FamilyProfileScreenController extends BaseScaffoldController {}
