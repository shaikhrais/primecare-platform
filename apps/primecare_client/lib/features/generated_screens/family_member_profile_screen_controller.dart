// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyMemberProfileScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final familyMemberProfileScreenControllerProvider =
    NotifierProvider<
      FamilyMemberProfileScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyMemberProfileScreenController();
    });

class FamilyMemberProfileScreenController extends BaseScaffoldController {}
