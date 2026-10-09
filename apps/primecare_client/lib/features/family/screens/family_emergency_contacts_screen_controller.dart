// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyEmergencyContactsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final familyEmergencyContactsScreenControllerProvider =
    NotifierProvider<
      FamilyEmergencyContactsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyEmergencyContactsScreenController();
    });

class FamilyEmergencyContactsScreenController extends BaseScaffoldController {}
