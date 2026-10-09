// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyMemberEmergencyContactsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final familyMemberEmergencyContactsScreenControllerProvider =
    NotifierProvider<
      FamilyMemberEmergencyContactsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyMemberEmergencyContactsScreenController();
    });

class FamilyMemberEmergencyContactsScreenController
    extends BaseScaffoldController {}
